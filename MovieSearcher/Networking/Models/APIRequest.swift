//
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

/// All requests must conform to this protocol
/// - Discussion: You must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol APIRequest: Encodable {
	/// Response (will be wrapped with a DataContainer)
	associatedtype Response: Decodable

	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
}
