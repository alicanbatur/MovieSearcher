import Foundation

// Dumb error to model simple errors
// In a real implementation this should be more exhaustive
// These are enough for now, I guess. 
public enum MovieError: Error {
	case decoding
	case server(message: String)
}
