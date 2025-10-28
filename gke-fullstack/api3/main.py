from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"service": "api3", "message": "Hello from FastAPI API3 on GKE"}
