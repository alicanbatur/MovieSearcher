import Foundation

// Top level response.
// This can be generic. But I did it simple for the requested assignment.
public struct Response: Decodable {
    
    public let message: String?
    
    public let page: Int?
    public let totalResults: Int?
    public let totalPages: Int?
    public let movies: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
        case message = "status_message"
    }
}
