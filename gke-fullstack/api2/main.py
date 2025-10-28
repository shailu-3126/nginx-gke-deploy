from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"service": "api2", "message": "Hello from FastAPI API2 on GKE"}
