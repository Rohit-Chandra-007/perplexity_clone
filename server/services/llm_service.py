import google.generativeai as genai

from config import Settings

settings = Settings()


class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-2.0-pro-exp-02-05")

    def generate_response(self, query: str, search_result: list[dict]):
        context_text = "\n\n".join([
            f"Source {i + 1} ({result['url']}):\n{result['content']}"
            for i, result in enumerate(search_result)
        ])
        full_prompt = f"""
        Context from Web Search:
        {context_text}

        Query:{query}

        Please Provide a comprehensive, detailed, well-cited accurate respone using the above context. Think and reson deeply. Ensure it answers the query the user is asking. Do not use your knowledge until it is absolutely necessary
        """

        response = self.model.generate_content(full_prompt, stream=True)

        for chunk in response:
            yield chunk.text
