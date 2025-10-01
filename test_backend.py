#!/usr/bin/env python3
"""
Simple test script to verify the backend WebSocket is working
"""
import asyncio
import json
import websockets

async def test_websocket():
    uri = "ws://localhost:8000/ws/chat"
    
    try:
        print("Connecting to WebSocket...")
        async with websockets.connect(uri) as websocket:
            print("Connected! Sending test query...")
            
            # Send a test query
            test_query = {"query": "What is artificial intelligence?"}
            await websocket.send(json.dumps(test_query))
            print(f"Sent: {test_query}")
            
            # Listen for responses
            response_count = 0
            async for message in websocket:
                data = json.loads(message)
                print(f"Received: {data['type']} - {len(str(data['data']))} chars")
                
                response_count += 1
                if response_count > 10:  # Limit responses for testing
                    break
                    
                if data['type'] == 'complete':
                    print("Response completed!")
                    break
                    
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    print("Testing WebSocket connection...")
    asyncio.run(test_websocket())