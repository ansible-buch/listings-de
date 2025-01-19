#!/usr/bin/env python3

from flask import Flask
from wsgiref.handlers import CGIHandler

app = Flask(__name__)

@app.route('/')
def hello_world():
    return "<h1>Hello, World!</h1>"

if __name__ == '__main__':
    CGIHandler().run(app)
