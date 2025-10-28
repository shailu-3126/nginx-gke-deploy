#!/usr/bin/env bash
set -eu

PROJECT="test-teraform-vm"
REG="asia-south1"
REPO="fastapi-repo"
NS="demo"

images=( "backend1" "backend2" "backend3" "frontend-nginx" )

echo "Tagging found digests as :latest in ${REG}-docker.pkg.dev/${PROJECT}/${REPO} ..."

for img in "${images[@]}"; do
  # get the most recent digest (if any)
  DIGEST=$(gcloud artifacts docker images list "${REG}-docker.pkg.dev/${PROJECT}/${REPO}/${img}" \
    --project="${PROJECT}" --limit=5 --format="value(DIGEST)" 2>/dev/null | head -n1 || true)

  if [ -z "${DIGEST}" ]; then
    echo "ERROR: No digest found for ${img} in repo ${REPO}. Skipping ${img}."
    continue
  fi

  SRC="${REG}-docker.pkg.dev/${PROJECT}/${REPO}/${img}@${DIGEST}"
  DST="${REG}-docker.pkg.dev/${PROJECT}/${REPO}/${img}:latest"

  echo "Tagging ${SRC} -> ${DST}"
  gcloud artifacts docker images add-tag "${SRC}" "${DST}" --project="${PROJECT}"
done

echo
echo "Restarting deployments to pull :latest images..."
kubectl rollout restart deployment backend1 backend2 backend3 nginx-proxy -n "${NS}"

# Wait loop (timeout 300s) to avoid an infinite watch that might hang your session
echo "Waiting up to 300s for pods to become Ready..."
end=$((SECONDS+300))
while [ $SECONDS -lt $end ]; do
  kubectl get pods -n "${NS}" --no-headers || true
  # check readiness
  not_ready_count=$(kubectl get pods -n "${NS}" --no-headers | awk '{print $2}' | grep -cv '^1/1$' || true)
  if [ "$not_ready_count" = "0" ]; then
    echo "All pods Ready."
    exit 0
  fi
  sleep 5
done

echo "Timeout reached. Some pods are still not Ready. Run:"
echo "  kubectl get pods -n ${NS}"
echo "  kubectl describe pod <pod-name> -n ${NS}"
exit 2
