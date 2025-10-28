# 3. Install MongoDB
helm install my-mongo bitnami/mongodb -n mongo -f mongodb-values.yaml
# 4. Wait for PVC to be Bound first
kubectl wait --for=condition=Bound pvc/my-mongo-mongodb -n mongo --timeout=180s
# 5. Wait for pods to be ready (up to 5 minutes)
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/instance=my-mongo -n mongo --timeout=300s
# 6. Show final status
kubectl get pods -n mongo
kubectl get pvc -n mongo
kubectl get svc -n mongo
# 7. Export root password for connections
export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongo my-mongo-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)
echo "MongoDB root password is stored in \$MONGODB_ROOT_PASSWORD"
# 8. Optional: connect inside cluster
echo "Connect with:"
echo "kubectl run --namespace mongo my-mongo-client --rm --tty -i --restart='Never' --env=\"MONGODB_ROOT_PASSWORD=\$MONGODB_ROOT_PASSWORD\" --image registry-1.docker.io/bitnami/mongodb:latest --command -- bash"
# 1. Cleanup old release and PVCs
helm uninstall my-mongo -n mongo 2>/dev/null || true
kubectl delete pvc -n mongo --all 2>/dev/null || true
kubectl create namespace mongo 2>/dev/null || true
# 2. Create a clean values file
cat <<EOF > mongodb-values.yaml
replicaSet:
  enabled: true
  name: rs0

auth:
  rootPassword: mysecurepassword
  username: myuser
  password: mysecurepassword
  database: mydatabase

primary:
  persistence:
    enabled: true
    storageClass: "standard-rwo"   # Use WaitForFirstConsumer compatible SC
    size: 8Gi

service:
  type: ClusterIP
  port: 27017
EOF

# 3. Install MongoDB
helm install my-mongo bitnami/mongodb -n mongo -f mongodb-values.yaml
# 4. Wait for PVC to be Bound first
kubectl wait --for=condition=Bound pvc/my-mongo-mongodb -n mongo --timeout=180s
# 5. Wait for pods to be ready (up to 5 minutes)
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/instance=my-mongo -n mongo --timeout=300s
# 6. Show final status
kubectl get pods -n mongo
kubectl get pvc -n mongo
kubectl get svc -n mongo
# 7. Export root password for connections
export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongo my-mongo-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)
echo "MongoDB root password is stored in \$MONGODB_ROOT_PASSWORD"
# 8. Optional: connect inside cluster
echo "Connect with:"
echo "kubectl run --namespace mongo my-mongo-client --rm --tty -i --restart='Never' --env=\"MONGODB_ROOT_PASSWORD=\$MONGODB_ROOT_PASSWORD\" --image registry-1.docker.io/bitnami/mongodb:latest --command -- bash"
# 1. Cleanup old release and PVCs
helm uninstall my-mongo -n mongo 2>/dev/null || true
kubectl delete pvc -n mongo --all 2>/dev/null || true
kubectl create namespace mongo 2>/dev/null || true
# 2. Create a clean values file
cat <<EOF > mongodb-values.yaml
replicaSet:
  enabled: true
  name: rs0

auth:
  rootPassword: mysecurepassword
  username: myuser
  password: mysecurepassword
  database: mydatabase

primary:
  persistence:
    enabled: true
    storageClass: "standard-rwo"   # Use WaitForFirstConsumer compatible SC
    size: 8Gi

service:
  type: ClusterIP
  port: 27017
EOF

# 3. Install MongoDB
helm install my-mongo bitnami/mongodb -n mongo -f mongodb-values.yaml
# 4. Wait for PVC to be Bound first
kubectl wait --for=condition=Bound pvc/my-mongo-mongodb -n mongo --timeout=180s
# 5. Wait for pods to be ready (up to 5 minutes)
kubectl get pods -n databases
kubectl get ns
kubectl get pods -n postgres-ns
kubectl port-forward svc/postgres 5432:5432 -n postgres-ns
kubectl get svc -n postgres-ns
kubectl port-forward svc/my-postgres-postgresql 5432:5432 -n postgres-ns
kubectl get secret -n postgres-ns my-postgres-postgresql -o yaml
echo "BASE64_STRING" | base64 --decode
echo "WTE5YTE1Mk5saw==" | base64 --decode
postgres
kubectl get secret -n postgres-ns my-postgres-postgresql -o jsonpath="{.data.postgresql-username}" | base64 --decode
psql -h localhost -p 5432 -U user -d postgres
kubectl get secret -n postgres-ns my-postgres-postgresql -o yaml
helm upgrade my-postgres bitnami/postgresql   --namespace postgres-ns   --set auth.username=priii   --set auth.password=MyStrongPassword123!   --set auth.database=mydatabase
ls
clear
python3 --version
git --version
docker --version
gcloud version
kubectl version --client
gcloud auth list
# Set variables
REGION="asia-south1"
REPO_NAME="nginx-repo"
# Create Artifact Registry
gcloud artifacts repositories create $REPO_NAME   --repository-format=docker   --location=$REGION   --description="Docker repo for NGINX images"
# Verify
gcloud artifacts repositories list --location=$REGION
gcloud config set project test-kumar-makala
# Set variables
REGION="asia-south1"
REPO_NAME="nginx-repo"
# Create Artifact Registry
gcloud artifacts repositories create $REPO_NAME   --repository-format=docker   --location=$REGION   --description="Docker repo for NGINX images"
# Verify it was created
gcloud artifacts repositories list --location=$REGION
CLUSTER_NAME="nginx-cluster"
# Create GKE cluster with 2 nodes
gcloud container clusters create $CLUSTER_NAME   --region $REGION   --num-nodes 2
# Get credentials for kubectl
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION
# Verify nodes
kubectl get nodes
CLUSTER_NAME="nginx-cluster"
gcloud container clusters create $CLUSTER_NAME   --region $REGION   --num-nodes 2
CLUSTER_NAME="nginx-cluster-small"
gcloud container clusters create $CLUSTER_NAME   --region $REGION   --num-nodes 1   --machine-type=e2-small
CLUSTER_NAME="nginx-autopilot"
gcloud container clusters create-auto $CLUSTER_NAME   --region $REGION
gcloud container clusters list --region=asia-south1
gcloud container clusters list --region=us-central1
gcloud container clusters delete gke-demo-cluster --region=asia-south1
CLUSTER_NAME="nginx-cluster-small"
REGION="asia-south1"
gcloud container clusters create $CLUSTER_NAME   --region=$REGION   --num-nodes=1   --machine-type=e2-small
CLUSTER_NAME="nginx-cluster-small"
REGION="asia-south1"
gcloud container clusters create $CLUSTER_NAME   --region=$REGION   --num-nodes=1   --machine-type=e2-small   --disk-type=pd-standard
gcloud container clusters get-credentials nginx-cluster-small --region=asia-south1
kubectl get nodes
PROJECT_ID=$(gcloud config get-value project)
gcloud iam service-accounts create github-deployer --display-name "GitHub Actions Deployer"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:github-deployer@$PROJECT_ID.iam.gserviceaccount.com"   --role="roles/container.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:github-deployer@$PROJECT_ID.iam.gserviceaccount.com"   --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:github-deployer@$PROJECT_ID.iam.gserviceaccount.com"   --role="roles/iam.serviceAccountUser"
gcloud iam service-accounts keys create key.json   --iam-account=github-deployer@$PROJECT_ID.iam.gserviceaccount.com
# Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
cat > Dockerfile <<'EOF'
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

nano index.html
ls
REGION="asia-south1"
gcloud auth configure-docker ${REGION}-docker.pkg.dev
PROJECT_ID=$(gcloud config get-value project)
REPO_NAME="nginx-repo"
IMAGE_NAME="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/nginx-demo:v1"
docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
nano nginx-deployment.yaml
nano nginx-service.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
cat > nginx-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-demo
  labels:
    app: nginx-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-demo
  template:
    metadata:
      labels:
        app: nginx-demo
    spec:
      containers:
      - name: nginx
        image: asia-south1-docker.pkg.dev/test-kumar-makala/nginx-repo/nginx-demo:v1
        ports:
        - containerPort: 80
EOF

cat > nginx-service.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: nginx-demo-service
spec:
  type: LoadBalancer
  selector:
    app: nginx-demo
  ports:
  - port: 80
    targetPort: 80
EOF

kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl get pods
kubectl get svc
docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
nano nginx-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl get pods
kubectl get svc
Successfully built <image_id>
Successfully tagged asia-south1-docker.pkg.dev/test-kumar-makala/nginx-repo/nginx-demo:v1
docker push asia-south1-docker.pkg.dev/test-kumar-makala/nginx-repo/nginx-demo:v1
gcloud iam service-accounts create github-actions   --display-name "GitHub Actions for GKE"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-actions@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/container.admin"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-actions@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/storage.admin"
gcloud iam service-accounts keys create key.json   --iam-account=github-actions@test-kumar-makala.iam.gserviceaccount.com
cat key.json
export PROJECT_ID=test-kumar-makala
export GAR_LOCATION=asia-south1
export GAR_REPO=fast-api-repo
export CLUSTER_NAME=gke-demo-cluster
export CLUSTER_REGION=asia-south1
export SA_NAME=github-actions-sa
gcloud config set project $PROJECT_ID
gcloud services enable artifactregistry.googleapis.com container.googleapis.com
gcloud artifacts repositories create $GAR_REPO   --repository-format=docker   --location=$GAR_LOCATION   --description="Docker images for fast_api_sample"
gcloud artifacts repositories list --location=$GAR_LOCATION
gcloud container clusters create $CLUSTER_NAME   --region $CLUSTER_REGION   --num-nodes=2   --machine-type=e2-medium
gcloud container clusters create $CLUSTER_NAME   --region $CLUSTER_REGION   --num-nodes=2   --machine-type=e2-small   --disk-size=20   --project $PROJECT_ID
# List all clusters (even from other regions)
gcloud container clusters list --project test-kumar-makala --format="table(name,location,status)"
# List all Compute Engine VMs
gcloud compute instances list --project test-kumar-makala --format="table(name,zone,status)"
gcloud container clusters delete gke-demo-postgres --region us-central1 --quiet
gcloud container clusters delete gke-demo-postgres   --zone us-central1-a   --project test-kumar-makala   --quiet
gcloud container clusters delete gke-demo-postgres --zone us-central1-a --quiet
gcloud container clusters list --project test-kumar-makala
gcloud container clusters delete mongodb-cluster-3   --zone us-central1-a   --project test-kumar-makala   --quiet
gcloud container clusters delete nginx-cluster   --zone us-central1-a   --project test-kumar-makala   --quiet
gcloud container clusters delete rf-cluster-new   --zone us-east1-c   --project test-kumar-makala   --quiet
gcloud container clusters delete pg-cluster   --region us-west1   --project test-kumar-makala   --quiet
gcloud container clusters list --project test-kumar-makala
gcloud compute instances list --project test-kumar-makala
gcloud compute project-info describe --project test-kumar-makala | grep -A5 CPUS
export CLUSTER_NAME=gke-demo-cluster
export CLUSTER_REGION=asia-south1
gcloud container clusters create $CLUSTER_NAME   --region $CLUSTER_REGION   --num-nodes=2   --machine-type=e2-small   --disk-size=20   --project test-kumar-makala
gcloud compute instances list --project test-kumar-makala --filter="zone:(asia-south1-a asia-south1-b asia-south1-c)"
gcloud container clusters delete nginx-cluster-small --region asia-south1 --project test-kumar-makala --quiet
gcloud compute instances list --project test-kumar-makala
gcloud container clusters get-credentials gke-demo-cluster --region asia-south1 --project test-kumar-makala
gcloud container clusters describe gke-demo-cluster --region asia-south1 --project test-kumar-makala --format="value(status)"
gcloud container clusters describe gke-demo-cluster   --region asia-south1   --project test-kumar-makala   --format="value(status)"
gcloud container clusters describe gke-demo-cluster   --region asia-south1   --project test-kumar-makala   --format="value(status)"
gcloud container clusters describe gke-demo-cluster --region asia-south1 --project test-kumar-makala --format="value(status)"
gcloud container clusters list --project test-kumar-makala --region asia-south1
gcloud container clusters delete gke-demo-cluster   --region asia-south1   --project test-kumar-makala   --quiet
gcloud container clusters create fastapi-cluster   --region asia-south1   --num-nodes=1   --machine-type=e2-micro   --disk-size=20   --enable-ip-alias   --project test-kumar-makala
clear
gcloud auth login
gcloud config set project test-kumar-makala   # use your project ID
cd backend-gke-deploy-shailu
clear
cd backend-gke-deploy-shailu
docker build -t gcr.io/test-kumar-makala/backend-gke-shailu:v1 .
gcloud auth configure-docker
docker push gcr.io/test-kumar-makala/backend-gke-shailu:v1
gcloud container clusters get-credentials <cluster-name> --zone <zone> --project test-kumar-makala
kubectl apply -f deployment.yaml
kubectl get service backend-shailu-service
gcloud container clusters get-credentials fastapi-cluster --region asia-south1 --project test-kumar-makala
nano deployment.yaml
kubectl apply -f deployment.yaml
kubectl get pods
kubectl get service backend-shailu-service
kubectl get pods -w
kubectl get svc backend-shailu-service -w
curl http://34.14.167.215
nano deployment.yaml
kubectl apply -f deployment.yaml
kubectl get pods -w
curl http://34.14.167.215
curl http://34.14.167.21515
curl http://34.14.167.215
curl http://34.14.167.21515
kubectl describe service backend-shailu-service
kubectl exec -it $(kubectl get pods -o name | grep backend-shailu-deployment | head -n 1) -- netstat -tuln
kubectl exec -it $(kubectl get pods -o name | grep backend-shailu-deployment | head -n 1) -- ps aux
nano Dockerfile
cat Dockerfile
kubectl get deployment backend-shailu-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}'; echo
gcloud auth login
gcloud auth configure-docker gcr.io
kubectl exec -it $(kubectl get pods -o name | grep backend-shailu-deployment | head -n 1) -- sh -c "apt update && apt install -y net-tools && netstat -tuln"
kubectl edit service backend-shailu-service
kubectl get svc backend-shailu-service
curl http://34.14.167.215
kubectl edit svc backend-shailu-service
kubectl get svc backend-shailu-service -o yaml | grep targetPort
kubectl patch svc backend-shailu-service -p '{"spec": {"ports": [{"port": 80, "targetPort": 8080}]}}'
kubectl get svc backend-shailu-service -o yaml | grep targetPort
kubectl get svc backend-shailu-service
curl http://34.14.167.215
# 1. Create service account
gcloud iam service-accounts create github-deployer   --description="GitHub Actions deployer"   --display-name="GitHub Deployer"
# 2. Bind permissions (give deploy and container access)
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/container.admin"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/storage.admin"
# 3. Create and download key file
gcloud iam service-accounts keys create key.json   --iam-account=github-deployer@test-kumar-makala.iam.gserviceaccount.com
key.json
cat key.json
gcloud config set project test-kumar-makala
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com
clear
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud container clusters create backend-cluster   --num-nodes=2   --zone=us-central1-a
sudo apt-get install -y helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
kubectl create namespace postgres-ns
helm install my-postgres bitnami/postgresql -n postgres-ns   --set auth.username=appuser   --set auth.password=StrongPass123   --set auth.database=appdb
kubectl get pods -n postgres-ns
kubectl get svc -n postgres-ns
gcloud auth configure-docker
docker build -t gcr.io/test-kumar-makala/backend-app:latest .
docker push gcr.io/test-kumar-makala/backend-app:latest
kubectl apply -f backend-deployment.yaml
# Authenticate with your GCP account
gcloud auth login
# Set your project
gcloud config set project test-kumar-makala
# Get cluster credentials
gcloud container clusters get-credentials backend-cluster --zone us-central1-a --project test-kumar-makala
kubectl get nodes
kubectl apply -f backend-deployment.yaml
nano backend-deployment.yaml
kubectl apply -f backend-deployment.yaml
kubectl get pods
kubectl get svc
curl http://34.27.79.39/
curl http://34.27.79.39/db-test
kubectl get svc -A
curl http://34.27.79.39
git add .
git commit -m "Update NGINX homepage"
git push
ls
cd backend-gke-deploy-shailu
ls
git init
git branch -M main
git add .
git commit -m "Initial commit - backend GKE deployment"
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git
git push -u origin main
cd ~/backend-gke-deploy-shailu
ls
git init
git add .
git commit -m "Initial commit - backend GKE deployment"
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git 
git branch -M main
git push -u origin main
git remote -v
git remote remove origin
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git
git add .
git commit -m "Initial commit - backend GKE deployment"
git branch -M main
git push -u origin main
git remote remove origin
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git
git add .
git commit -m "Initial commit - backend GKE deployment"
clear
gcloud compute instances list
cd ..
gcloud compute firewall-rules create allow-8019   --allow=tcp:8019   --direction=INGRESS   --priority=1000   --description="Allow external access to FastAPI on port 8019"   --target-tags=allow-8019
gcloud compute instances add-tags kxn --tags=allow-8019 --zone=YOUR_ZONE
gcloud compute instances add-tags kxn --tags=allow-8019 --zone=asia-south1-a
curl -v http://34.83.254.172:8019/users
gcloud compute instances list --format='table(name,zone,EXTERNAL_IP)'
gcloud compute instances list --filter="EXTERNAL_IP:34.83.254.172" --format="table(name,zone,EXTERNAL_IP)"
gcloud compute firewall-rules create allow-fastapi-8019   --allow=tcp:8019   --direction=INGRESS   --priority=1000   --target-tags=fastapi-server   --description="Allow FastAPI traffic on port 8019"
ls
git status
gcloud compute instances list --format="json"   | python3 - <<'PY'
import json,sys
j=json.load(sys.stdin)
found=False
for i in j:
  name=i.get("name")
  zone=i.get("zone","").split("/")[-1]
  for ni in i.get("networkInterfaces",[]):
    for ac in ni.get("accessConfigs",[]):
      if ac.get("natIP")=="34.83.254.172":
        print(name, zone)
        found=True
if not found:
  print("NOT_FOUND")
PY

cd ~/backend-gke-deploy-shailu
git status
git commit -m "Initial commit - backend GKE deployment"
git remote -v
gcloud projects list --format="table(projectId, name)"
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git
git branch -M main
git push -u origin main
gcloud compute instances list --filter="EXTERNAL_IP:34.83.254.172" --format="table(name,zone,EXTERNAL_IP)"
git commit -m "Initial commit - backend GKE deployment"
gcloud compute firewall-rules create allow-fastapi-8019   --allow=tcp:8019   --direction=INGRESS   --priority=1000   --target-tags=fastapi-server   --description="Allow FastAPI on port 8019" || true
gcloud compute instances add-tags kxn --tags=fastapi-server --zone=us-west1-a
gcloud compute ssh kxn --zone=us-west1-a --command="sudo docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}'; echo '---'; sudo ss -ltnp | grep -E ':8019|:8000' || true; echo '---'; curl -sS -D - http://127.0.0.1:8019/users | sed -n '1,20p'"
gcloud compute ssh kxn --zone=us-west1-a --command="sudo ufw allow 8019/tcp || true; sudo ufw reload || true; sudo ufw status verbose || echo 'ufw not active'"
git config --global user.name "shailu-3126"
git config --global user.email "nshailu2003@gmail.com"
git commit -m "Initial commit - backend GKE deployment"
git branch -M main
git push -u origin main
git branch -M main
git push -u origin main
cat ~/.ssh/id_ed25519.pub
ssh-keygen -t ed25519 -C "nshailu2003@gmail.com"
cat ~/.ssh/id_ed25519.pub
rm -rf ~/.ssh
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t ed25519 -C "nshailu2003@gmail.com"
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
git remote set-url origin git@github.com:shailu-3126/nginx-gke-deploy.git
git push -u origin main
git remote set-url origin https://github.com/shailu-3126/nginx-gke-deploy
git push -u origin main
git remote set-url origin git@github.com:shailu-3126/nginx-gke-deploy.git
git remote -v
ssh -T git@github.com
git push -u origin main
# 1️⃣ First, fetch the remote branch
git fetch origin main
# 2️⃣ Merge remote changes into your local branch
git pull origin main --allow-unrelated-histories
# 3️⃣ Then push your local code to GitHub
git push -u origin main
git config pull.rebase false
git pull origin main --allow-unrelated-histories
git push -u origin main
# Create service account
gcloud iam service-accounts create github-cicd-deployer   --display-name="GitHub CI/CD Deployer"
# Assign roles (adjust project ID if needed)
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-cicd-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/container.developer"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-cicd-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/artifactregistry.writer"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-cicd-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/storage.admin"
gcloud projects add-iam-policy-binding test-kumar-makala   --member="serviceAccount:github-cicd-deployer@test-kumar-makala.iam.gserviceaccount.com"   --role="roles/viewer"
gcloud iam service-accounts keys create ~/github-cicd-key.json   --iam-account=github-cicd-deployer@test-kumar-makala.iam.gserviceaccount.com
json
download ~/github-cicd-key.json
cat ~/github-cicd-key.json
(Get-Content -Raw .\github-cicd-key.json) -replace "`r`n", "\n" | clip
gcloud config set project test-kumar-makala
gcloud config get-value project
gcloud services enable artifactregistry.googleapis.com container.googleapis.com iam.googleapis.com
gcloud iam service-accounts create github-actions-cicd   --display-name="GitHub Actions CI/CD"
PROJECT=test-kumar-makala
SA_EMAIL=github-actions-cicd@$PROJECT.iam.gserviceaccount.com
# Artifact Registry writer
gcloud projects add-iam-policy-binding $PROJECT   --member="serviceAccount:$SA_EMAIL"   --role="roles/artifactregistry.writer"
# GKE developer (allows get-credentials and deployments)
gcloud projects add-iam-policy-binding $PROJECT   --member="serviceAccount:$SA_EMAIL"   --role="roles/container.developer"
gcloud iam service-accounts keys create github-actions-sa-key.json   --iam-account=$SA_EMAIL
gcloud artifacts repositories create fastapi-repo   --repository-format=docker   --location=asia-south1   --description="Docker repo for FastAPI images"
ls
gcloud artifacts repositories list --project=test-kumar-makala
gcloud container clusters list --project=test-kumar-makala --region=asia-south1
gcloud iam service-accounts list --project=test-kumar-makala
gcloud container clusters list
backend-cluster  (us-central1-a)
gcloud container clusters get-credentials backend-cluster --zone us-central1-a --project test-kumar-makala
kubectl get nodes
code .github/workflows/deploy.yml
nano .github/workflows/deploy.yml
pwd
mkdir -p .github/workflows
nano .github/workflows/deploy.yml
cat .github/workflows/deploy.yml
git init
git remote add origin https://github.com/shailu-3126/nginx-gke-deploy.git
git fetch origin
git checkout main
mkdir ~/backup-deploy
mv .github backend-app ~/backup-deploy/
git checkout main
mkdir -p .github/workflows
cp ~/backup-deploy/.github/workflows/deploy.yml .github/workflows/
cp -r ~/backup-deploy/backend-app ./backend-app
git add .
git commit -m "Add deploy workflow for GKE backend"
