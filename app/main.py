from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

def analyze_sentiment(text):
    """Simple sentiment analysis based on keywords"""
    positive_words = ['good', 'great', 'excellent', 'amazing', 'wonderful', 'fantastic', 'love', 'like', 'happy', 'pleased']
    negative_words = ['bad', 'terrible', 'awful', 'horrible', 'hate', 'dislike', 'sad', 'angry', 'disappointed', 'worst']
    
    text_lower = text.lower()
    positive_count = sum(1 for word in positive_words if word in text_lower)
    negative_count = sum(1 for word in negative_words if word in text_lower)
    
    if positive_count > negative_count:
        return {'label': 'POSITIVE', 'score': min(0.95, 0.5 + (positive_count * 0.1))}
    elif negative_count > positive_count:
        return {'label': 'NEGATIVE', 'score': min(0.95, 0.5 + (negative_count * 0.1))}
    else:
        return {'label': 'NEUTRAL', 'score': 0.5}

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.get_json()
    text = data.get('text', '')
    
    if not text:
        return jsonify({'error': 'No text provided'}), 400
    
    try:
        result = analyze_sentiment(text)
        return jsonify({
            'text': text,
            'sentiment': result['label'],
            'confidence': result['score']
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
