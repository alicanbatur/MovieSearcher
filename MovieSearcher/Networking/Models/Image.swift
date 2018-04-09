import Foundation

public struct Image: Decodable {
	/// Server sends the remote URL splits in two: the path and the extension
	enum ImageKeys: String, CodingKey {
		case path = "path"
		case fileExtension = "extension"
	}

	/// The remote URL for this image
	public let url: URL

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ImageKeys.self)

		let path = try container.decode(String.self, forKey: .path)
		let fileExtension = try container.decode(String.self, forKey: .fileExtension)

		guard let url = URL(string: "\(path).\(fileExtension)") else { throw MovieError.decoding }

		self.url = url
	}
}
