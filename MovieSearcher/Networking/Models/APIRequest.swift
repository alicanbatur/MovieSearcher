//
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

/// All requests must conform to this protocol
public protocol APIRequest: Encodable {
	associatedtype Response: Decodable
	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
}
