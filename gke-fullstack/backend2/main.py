from fastapi import FastAPI
app = FastAPI()

@app.get("/api2")
def read_api2():
    return {"message": "Hello from FastAPI2"}
