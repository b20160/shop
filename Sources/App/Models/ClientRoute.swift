//
//  ClientRoute.swift
//  App
//
//  Created by Jonathan Green on 10/4/18.
//

import Vapor

enum ClientRoute {
    case token(tokenRequest:TokenRequest)
    case platforms
    case products
    case productDescription(id:String)
    case productImage(id:String)
    case orders(orders:Orders)
    
    func request() throws -> HTTPRequest {
        var httpReq = HTTPRequest()
        switch self {
            case .token(let tokenRequest):
                httpReq = HTTPRequest(method: .POST, url: "\(Constants().URL)/oauth/token?grant_type=client_credentials&client_id=\(tokenRequest.client_id)&client_secret=\(tokenRequest.client_secret)")
                httpReq.contentType = .json
            case .orders(let orders):
                httpReq = HTTPRequest(method: .POST, url: "\(Constants().URL)/v2/orders")
                httpReq.contentType = .json
                let jsonDecoder = JSONEncoder()
                let data = try jsonDecoder.encode(orders)
                httpReq.body = HTTPBody(data: data)
                httpReq.headers.bearerAuthorization = BearerAuthorization(token: Token.shared.access_token)
            case .platforms:
                httpReq = HTTPRequest(method: .GET, url: "\(Constants().URL)/v2/platforms")
                httpReq.contentType = .json
                httpReq.headers.bearerAuthorization = BearerAuthorization(token: Token.shared.access_token)
            case .products:
                httpReq = HTTPRequest(method: .GET, url: "\(Constants().URL)/v2/products")
                httpReq.contentType = .json
                httpReq.headers.bearerAuthorization = BearerAuthorization(token: Token.shared.access_token)
            case .productDescription(let id):
                httpReq = HTTPRequest(method: .GET, url: "\(Constants().URL)/v2/products/\(id)/description")
                httpReq.contentType = .json
                httpReq.headers.bearerAuthorization = BearerAuthorization(token: Token.shared.access_token)
            case .productImage(let id):
                httpReq = HTTPRequest(method: .GET, url: "\(Constants().URL)/v2/productImages/\(id)")
                httpReq.contentType = .json
                httpReq.headers.bearerAuthorization = BearerAuthorization(token: Token.shared.access_token)
        }
        return httpReq
    }
}
