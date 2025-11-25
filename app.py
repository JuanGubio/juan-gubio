from flask import Flask, request, jsonify
import openai
import os

# Aplicación Flask con IA

app = Flask(__name__)

openai.api_key = os.getenv('OPENAI_API_KEY')

@app.route('/')
def home():
    return "Hola, soy la app de Juan Gubio con IA corriendo en Docker 😎"

@app.route('/ai', methods=['POST'])
def ai_chat():
    data = request.get_json()
    message = data.get('message', '')
    if not message:
        return jsonify({'error': 'No message provided'}), 400

    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": message}],
            max_tokens=150
        )
        ai_response = response.choices[0].message.content.strip()
        return jsonify({'response': ai_response})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)