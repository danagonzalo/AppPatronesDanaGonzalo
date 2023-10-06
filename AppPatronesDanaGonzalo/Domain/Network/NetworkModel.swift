import Foundation

final class NetworkModel {
    enum NetworkError: Error {
        case unknown
        case malformedUrl
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code: Int?)
        case noToken
    }

    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        
        return components
    }

    // MARK: -  Token
    private var token = "eyJ0eXAiOiJKV1QiLCJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYifQ.eyJlbWFpbCI6ImRhbWRnb256YWxvQGdtYWlsLmNvbSIsImlkZW50aWZ5IjoiMzZFMkFBNEUtNEU5Qy00REUyLTg2MUItQTc2OTk0NTU3QjNDIiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.x56C06BpdVfs2rsHZDd50Soicjwn1SP8hDj1BssBZz8"
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Get heroes
    func getHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = urlComponents.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        createTask(for: request, using: [Hero].self, completion: completion)
    }
    
    
    // MARK: - Get transformations
    func getTransformations(for heroId: String, completion: @escaping (Result<[Transformation], NetworkError>) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: heroId)]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = urlComponents.query?.data(using: .utf8)
        createTask(
            for: request,
            using: [Transformation].self,
            completion: completion
        )
    }
    
    // MARK: - Create task
    func createTask<T: Decodable>(
        for request: URLRequest,
        using type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<T, NetworkError>
            
            defer {
                completion(result)
            }

            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            guard let resource = try? JSONDecoder().decode(type, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(resource)
        }
        
        task.resume()
    }
    

}
