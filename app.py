from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "Hello, Devops !",
        "status": "Application is running smoothlyy.."
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy ha boss"
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6969, debug=True)
