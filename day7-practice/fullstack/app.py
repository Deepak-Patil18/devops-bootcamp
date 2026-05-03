from flask import Flask, jsonify, request
from datetime import datetime
import os
import psycopg2

app = Flask(__name__)

DATABASE_URL = os.getenv("DATABASE_URL")

def get_conn():
    return psycopg2.connect(DATABASE_URL)

def init_db():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS tasks (
            id SERIAL PRIMARY KEY,
            title TEXT NOT NULL,
            status TEXT DEFAULT 'pending',
            created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    cur.close()
    conn.close()

@app.route('/')
def index():
    return jsonify({'name': 'Flask Task API', 'version': '2.0.0'})

@app.route('/tasks', methods=['GET'])
def get_tasks():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, title, status, created FROM tasks")
    rows = cur.fetchall()
    cur.close()
    conn.close()
from flask import Flask, jsonify, request
from datetime import datetime
import os
import psycopg2

app = Flask(__name__)

DATABASE_URL = os.getenv("DATABASE_URL")


def get_conn():
    return psycopg2.connect(DATABASE_URL)


def init_db():
    conn = get_conn()
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS tasks (
            id SERIAL PRIMARY KEY,
            title TEXT NOT NULL,
            status TEXT DEFAULT 'pending',
            created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)

    conn.commit()
    cur.close()
    conn.close()


init_db()


@app.route('/')
def index():
    return jsonify({
        'name': 'Flask Task API',
        'version': '2.0.0'
    })


@app.route('/tasks', methods=['GET'])
def get_tasks():
    conn = get_conn()
    cur = conn.cursor()

    cur.execute("SELECT id, title, status, created FROM tasks")
    rows = cur.fetchall()

    cur.close()
    conn.close()

    tasks = []

    for row in rows:
        tasks.append({
            'id': row[0],
            'title': row[1],
            'status': row[2],
            'created': str(row[3])
        })

    return jsonify({
        'tasks': tasks,
        'count': len(tasks)
    })


@app.route('/tasks', methods=['POST'])
def create_task():
    data = request.get_json()

    if not data or 'title' not in data:
        return jsonify({'error': 'title is required'}), 400

    conn = get_conn()
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO tasks (title) VALUES (%s) RETURNING id, title, status, created",
        (data['title'],)
    )

    row = cur.fetchone()
    conn.commit()

    cur.close()
    conn.close()

    return jsonify({
        'id': row[0],
        'title': row[1],
        'status': row[2],
        'created': str(row[3])
    }), 201

@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    conn = get_conn()
    cur = conn.cursor()

    cur.execute(
        "DELETE FROM tasks WHERE id = %s RETURNING id",
        (task_id,)
    )

    deleted = cur.fetchone()
    conn.commit()

    cur.close()
    conn.close()

    if not deleted:
        return jsonify({'error': 'Task not found'}), 404

    return jsonify({'message': 'Task deleted successfully'})

@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    data = request.get_json()

    if not data or 'title' not in data:
        return jsonify({'error': 'title is required'}), 400

    conn = get_conn()
    cur = conn.cursor()

    cur.execute(
        """
        UPDATE tasks
        SET title = %s
        WHERE id = %s
        RETURNING id, title, status, created
        """,
        (data['title'], task_id)
    )

    row = cur.fetchone()
    conn.commit()

    cur.close()
    conn.close()

    if not row:
        return jsonify({'error': 'Task not found'}), 404

    return jsonify({
        'id': row[0],
        'title': row[1],
        'status': row[2],
        'created': str(row[3])
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
