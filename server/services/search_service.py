import trafilatura

from config import Settings
from tavily import TavilyClient

setting = Settings()
tavily_client = TavilyClient(api_key=setting.TAVILY_API_KEY)


class SearchService:
    def web_search(self, query: str):
        results = []
        response = tavily_client.search(query, max_results=10)
        search_results = response.get("results", [])
        for result in search_results:
            try:
                downloaded = trafilatura.fetch_url(result.get('url'))
                content = trafilatura.extract(downloaded, include_comments=False)
                # Only add results where content was successfully extracted
                if content:
                    results.append({
                        'title': result.get('title', ''),
                        'url': result.get('url'),
                        'content': content
                    })
            except Exception as e:
                print(f"Error processing URL {result.get('url')}: {e}")
                continue
        return results
