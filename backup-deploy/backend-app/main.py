from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

# Read DB connection from environment variable
DATABASE_URL = os.getenv("DATABASE_URL")

@app.get("/")
def home():
    return {"message": "Backend is running on GKE!"}

@app.get("/db-test")
def db_test():
    try:
        conn = psycopg2.connect(DATABASE_URL)
        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()
        conn.close()
        return {"database_connection": "successful", "postgres_version": version[0]}
    except Exception as e:
        return {"database_connection": "failed", "error": str(e)}
