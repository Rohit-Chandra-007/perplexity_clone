from google import genai
from google.genai import types
from config import Settings

settings = Settings()


class LLMService:
    def __init__(self):
        self.client = genai.Client(api_key=settings.GEMINI_API_KEY)
        self.model_name = "gemini-2.5-pro"

    def generate_response(self, query: str, search_result: list[dict]):
        context_text = "\n\n".join(
            [
                f"Source {i + 1} ({result['url']}):\n{result['content']}"
                for i, result in enumerate(search_result)
            ]
        )

        full_prompt = f"""
        Context from Web Search:
        {context_text}

        Query: {query}

        Please provide a comprehensive, detailed, well-cited, and accurate response using the above context.
        Think and reason deeply. Ensure it answers the query the user is asking. Do not use your own knowledge
        unless absolutely necessary.
        """

        contents = [
            types.Content(
                role="user",
                parts=[types.Part.from_text(text=full_prompt)],
            )
        ]

        tools = [types.Tool(googleSearch=types.GoogleSearch())]

        config = types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_budget=-1),
            tools=tools,
            response_mime_type="text/plain",
        )

        response_stream = self.client.models.generate_content_stream(
            model=self.model_name, contents=contents, config=config
        )

        for chunk in response_stream:
            yield chunk.text
