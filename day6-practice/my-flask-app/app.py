from flask import Flask, jsonify, request
from datetime import datetime
import os

app = Flask(__name__)

tasks = []
next_id = 1

@app.route('/')
def index():
    return jsonify({
        'name': 'Flask Task API',
        'version': '1.0.0'
    })

@app.route('/health')
def health():
    return jsonify({'status': 'healthy', 'time': str(datetime.now())})

@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify({'tasks': tasks, 'count': len(tasks)})

@app.route('/tasks', methods=['POST'])
def create_task():
    global next_id
    data = request.get_json()
    if not data or 'title' not in data:
        return jsonify({'error': 'title is required'}), 400
    task = {
        'id': next_id,
        'title': data['title'],
        'status': 'pending',
        'created': str(datetime.now())
    }
    tasks.append(task)
    next_id += 1
    return jsonify(task), 201

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
