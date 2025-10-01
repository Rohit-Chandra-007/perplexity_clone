import asyncio
from fastapi import FastAPI, WebSocket

from pydantic_models.chat_body import ChatBody
from services.llm_service import LLMService
from services.search_service import SearchService
from services.sort_search_service import SortSearchService

app = FastAPI(
    title="Search Source API", description="Provide Authentic Sources", version="1.0.0"
)

search_service = SearchService()
sort_search_service = SortSearchService()
llm_service = LLMService()


@app.get("/")
def read_root():
    return {"Hello": "World"}


# REST API
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_results = search_service.web_search(body.query)
    sorted_results = sort_search_service.sort_source(body.query, search_results)
    if not isinstance(sorted_results, list):
        sorted_results = []
    response = llm_service.generate_response(body.query, sorted_results)
    return response


# chat websocket
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    print("WebSocket connection accepted")

    try:
        while True:
            # Wait for a message from the client
            data = await websocket.receive_json()
            query = data.get("query")
            
            if not query:
                await websocket.send_json({"type": "error", "data": "No query provided"})
                continue
            
            print(f"Received query: {query}")
            
            try:
                # Perform web search
                search_results = search_service.web_search(query)
                sorted_results = sort_search_service.sort_source(query, search_results)
                if not isinstance(sorted_results, list):
                    sorted_results = []
                
                # Send search results
                await websocket.send_json({"type": "search_result", "data": sorted_results})
                print(f"Sent {len(sorted_results)} search results")
                
                # Generate and stream LLM response
                response_count = 0
                for chunk in llm_service.generate_response(query, sorted_results):
                    await websocket.send_json({"type": "content", "data": chunk})
                    response_count += 1
                    await asyncio.sleep(0.05)  # Small delay to prevent overwhelming
                
                print(f"Sent {response_count} response chunks")
                
                # Send completion signal
                await websocket.send_json({"type": "complete", "data": "Response completed"})
                
            except Exception as e:
                print(f"Error processing query: {e}")
                await websocket.send_json({"type": "error", "data": f"Error processing query: {str(e)}"})
                
    except Exception as e:
        print(f"WebSocket error: {e}")
    finally:
        print("WebSocket connection closed")
        try:
            await websocket.close()
        except RuntimeError as e:
            print(f"WebSocket already closed: {e}")


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
