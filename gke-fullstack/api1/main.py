from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"service": "api1", "message": "Hello from FastAPI API1 on GKE"}
