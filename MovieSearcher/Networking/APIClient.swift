import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value>) -> Void

// Core request maker.
public class APIClient {
	private let baseEndpoint = "http://api.themoviedb.org/3/"
    private let session: URLSession = URLSession(configuration: .default)
	private let apiKey: String = "2696829a81b1b5827d515ff121700838"

    // Executes the request which is an object.
    // When request is completed, we let caller with the information using callback named completion.
    // This information could be error or success data.
    // This Response can be abstract, I did not made it abstract coz I wanted to make it simple for the assignment.
	public func execute<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<Response>) {
		let endpoint = self.endpoint(for: request)

		let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
			if let data = data {
				do {
					// Decode the top level response, and look up the decoded response to see
					// if it's a success or a failure
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    if let movies = response.movies, movies.count > 0 {
                        completion(.success(response))
                    } else if let movies = response.movies, movies.count == 0 {
                        completion(.failure(MovieError.server(message: "There is no item for this search.")))
                    } else if let message = response.message {
                        completion(.failure(MovieError.server(message: message)))
                    } else {
                        completion(.failure(MovieError.decoding))
                    }
                } catch {
					completion(.failure(error))
				}
			} else if let error = error {
				completion(.failure(error))
			}
		}
		task.resume()
	}

    // Endpoint builder.
	func endpoint<T: APIRequest>(for request: T) -> URL {
		guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
		// Construct the final URL with all the previous data
		return URL(string: "\(baseEndpoint)\(request.resourceName)?api_key=\(apiKey)&\(parameters)")!
	}
}
