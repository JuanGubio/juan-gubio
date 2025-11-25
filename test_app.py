import pytest
from app import app
import os

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hola, soy la app de Juan Gubio con IA corriendo en Docker' in response.data

def test_ai_no_message(client):
    response = client.post('/ai', json={})
    assert response.status_code == 400
    assert "No message provided" in response.get_json()['error']

def test_ai_with_message(client, monkeypatch):
    # Mock openai to avoid needing API key
    class MockResponse:
        class Choice:
            class Message:
                content = "Mock AI response"
            message = Message()
        choices = [Choice()]

    def mock_create(**kwargs):
        return MockResponse()

    monkeypatch.setattr('openai.ChatCompletion.create', mock_create)

    response = client.post('/ai', json={'message': 'Hello'})
    assert response.status_code == 200
    data = response.get_json()
    assert 'response' in data
    assert data['response'] == "Mock AI response"