from flask import Flask, request, jsonify
import joblib
import math

app = Flask(__name__)
model = joblib.load('iris_model.joblib')

FEATURES = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']

@app.route('/')
def home():
    return {'status': 'ok'}

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(silent=True)
    if not isinstance(data, dict):
        return jsonify({'error': 'Send a JSON object'}), 400
    missing = [name for name in FEATURES if name not in data]
    if missing:
        return jsonify({'error': 'Missing measurements', 'missing': missing}), 400
    try:
        values = [float(data[name]) for name in FEATURES]
    except (TypeError, ValueError):
        return jsonify({'error': 'All values must be numbers'}), 400
    if not all(math.isfinite(v) for v in values):
        return jsonify({'error': 'Values must be finite numbers'}), 400

    prediction = model.predict([values])[0]
    return jsonify({'prediction': str(prediction)})

