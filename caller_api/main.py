import os

from flask import Flask
from requests import get

app = Flask(__name__)

SERVICE_URL = os.getenv("SERVICE_URL")


@app.route("/")
def hello_world():
    result = get(SERVICE_URL)
    return f"<h1>Hello, {result.text}!</h1>"
