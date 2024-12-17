import Foundation
import CryptoKit

class SaltEdgeService {
    static let shared = SaltEdgeService()
    
    private let baseURL = "https://www.saltedge.com/api/v6"
    private let appId = "vwYWSmFdlUwjoQEzEkLrGbGskLJOUUWeb3s6D23pmQQ"
    private let appSecret = "AgqUST8PX92N2QyLag9fFbV4u8xJ-f7YuDW3IZzMy2g"
    
    private init() {}
    
    private func generateSignature(expires: Int, method: String, url: String, body: Data?) -> String {
        let cleanUrl = url.replacingOccurrences(of: baseURL, with: "")
        let fullPath = cleanUrl.hasPrefix("/") ? cleanUrl : "/" + cleanUrl
        
        var message = "\(expires)|\(method)|\(fullPath)"
        if let body = body {
            message += "|\(String(data: body, encoding: .utf8) ?? "")"
        }
        
        print("Signature message:", message)
        
        let key = SymmetricKey(data: Data(appSecret.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: key)
        return Data(signature).base64EncodedString()
    }
    
    private func createRequest(url: URL, method: String, body: [String: Any]? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let expires = Int(Date().timeIntervalSince1970) + 60
        
        let bodyData = body != nil ? try JSONSerialization.data(withJSONObject: body!) : nil
        request.httpBody = bodyData
        
        let signature = generateSignature(
            expires: expires,
            method: method,
            url: url.absoluteString,
            body: bodyData
        )
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appId, forHTTPHeaderField: "App-id")
        request.setValue("\(expires)", forHTTPHeaderField: "Expires-at")
        request.setValue(signature, forHTTPHeaderField: "Signature")
        request.setValue(appSecret, forHTTPHeaderField: "Secret")
        
        print("Request URL:", url)
        print("Request Method:", method)
        print("Request Headers:", request.allHTTPHeaderFields ?? [:])
        if let bodyData = request.httpBody {
            print("Request Body:", String(data: bodyData, encoding: .utf8) ?? "")
        }
        
        return request
    }
    
    func createCustomer(identifier: String) async throws -> String {
        let url = URL(string: "\(baseURL)/customers")!
        let body = [
            "data": [
                "identifier": identifier,
                "email": identifier
            ]
        ]
        
        let request = try createRequest(url: url, method: "POST", body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            let errorString = String(data: data, encoding: .utf8) ?? "Unknown error"
            print("Error response:", errorString)
            throw NSError(
                domain: "SaltEdgeError",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: errorString]
            )
        }
        
        let customerResponse = try JSONDecoder().decode(CustomerResponse.self, from: data)
        return customerResponse.data.customer_id
    }
    
    func createConnectSession(customerSecret: String) async throws -> String {
        let url = URL(string: "\(baseURL)/connections/connect")!
        let body = [
            "data": [
                "customer_id": customerSecret,
                "consent": [
                    "scopes": ["accounts", "transactions"]
                ],
                "attempt": [
                    "fetch_scopes": ["accounts", "transactions"],
                    "return_to": "saltedge-app://callback",
                    "store_credentials": true
                ],
                "return_connection_id": true,
                "provider": [
                    "code": "fake_oauth_client_xf",
                    "include_sandbox": true
                ]
            ]
        ]
        
        var request = try createRequest(url: url, method: "POST", body: body)
        request.setValue(appSecret, forHTTPHeaderField: "Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw NSError(
                domain: "SaltEdgeError",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: String(data: data, encoding: .utf8) ?? "Unknown error"]
            )
        }
        
        let connectResponse = try JSONDecoder().decode(ConnectSessionResponse.self, from: data)
        return connectResponse.data.connect_url
    }
}

// Response models
struct CustomerResponse: Codable {
    let data: CustomerData
    
    struct CustomerData: Codable {
        let customer_id: String
        let identifier: String
    }
}

struct ConnectSessionResponse: Codable {
    let data: ConnectSessionData
    
    struct ConnectSessionData: Codable {
        let connect_url: String
        let expires_at: String
        let customer_id: String
        
        enum CodingKeys: String, CodingKey {
            case connect_url = "connect_url"
            case expires_at = "expires_at"
            case customer_id = "customer_id"
        }
    }
} 