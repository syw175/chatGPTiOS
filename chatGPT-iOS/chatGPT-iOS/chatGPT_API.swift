//
//  chatGPT_API.swift
//  chatGPT-iOS
//
//  Created by Steven Wong on 2023-05-11.
//

import Foundation

class chatGPT_API {
    private let apiKey: String
    // For making API call
    private let urlSession = URLSession.shared
    private var urlRequest: URLRequest {
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var urlRequest = URLRequest(url:url)
        
        headers.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        return urlRequest
    }
    
    private let jsonDecoder = JSONDecoder()
    
    private var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
    }

    // Inject
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func jsonBody(text:String, stream: Bool = true) throws -> Data {
        let jsonBody: [String: Any] = [
            "model": "text-chat-davinci-002-20230126",
            // Temperature controls how much risk the model will take
            "temperature": 0.6,
            // Control spending of API, 1,000 tokens is 750 words
            "max_tokens": 2048,
            "prompt": text,
            // Sequences where API will stop generating further tokens, the returned string will not contain a stop sequence
            "stop": [
            "\n\n\n",
            "<|im_end|>"
            ],
            // Stream set to true to improve user speed
            "stream": stream,
            
            
            
            // WIP Code as Follows
            // Set the req confidnece level for each text_completion
            “choices": [
            "top_logprobs": positive,
                "index": 0,
            "finish_reason": errSecOutputLength(0)
            ]
            
        ]
        return try JSONSerialization.data(withJSONObject: jsonBody)
    }
}
