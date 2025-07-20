from typing import List

from sentence_transformers import SentenceTransformer
import numpy as np


class SortSearchService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-mpnet-base-v2")

    def sort_source(self, query: str, search_result: List[dict]):
        relevent_docs = []
        query_embedding = self.embedding_model.encode(query)
        try:
            for result in search_result:
                result_embedding = self.embedding_model.encode(result['content'])
                similarity = float(np.dot(query_embedding, result_embedding) / (
                        np.linalg.norm(query_embedding) * np.linalg.norm(result_embedding)
                ))
                result['relevence_score'] = similarity

                if similarity > 0.3:
                    relevent_docs.append(result)
            return sorted(relevent_docs, key=lambda x: x['relevence_score'], reverse=True)
        except Exception as e:

            print(e)
