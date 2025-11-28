import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import pytest
from app.main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_page(client):
    """Test that the home page loads correctly"""
    rv = client.get('/')
    assert rv.status_code == 200
    assert b'Examen' in rv.data

def test_analyze_endpoint_no_text(client):
    """Test the analyze endpoint with no text"""
    rv = client.post('/analyze', 
                     json={},
                     content_type='application/json')
    json_data = rv.get_json()
    
    assert rv.status_code == 400
    assert 'error' in json_data