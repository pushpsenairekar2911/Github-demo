//
//  GHNetworkServiceEndpointBuilder.swift
//  GHNetworkingService
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Foundation

public class GHNetworkServiceEndpointBuilder {
    
    private var path: GHAPIPath = .getUsers
    private var method: GHHTTPMethod = .get
    private var baseURL: GHBaseURL = .baseURL
    private var parameters: [String: String] = [:]
    
    public init() { }
    
    public init(
        path: GHAPIPath,
        method: GHHTTPMethod,
        baseURL: GHBaseURL,
        parameters: [String : String]) {
            self.path = path
            self.method = method
            self.baseURL = baseURL
            self.parameters = parameters
        }
    
    @discardableResult
    public func setPath(_ value: GHAPIPath) -> Self {
        self.path = value
        return self
    }
    
    // set the HTTPMethod.
    @discardableResult
    public func setMethod(_ value: GHHTTPMethod) -> Self {
        self.method = value
        return self
    }
    
    // set the BaseURL.
    @discardableResult
    public func setBaseURL(_ value: GHBaseURL) -> Self {
        self.baseURL = value
        return self
    }
    
    // set the Parameters.
    @discardableResult
    public func setParameters(_ value: [String: String]) -> Self {
        self.parameters = value
        return self
    }
    
    public func build() -> GHEndPoint {
        var endpoint = GHEndPointImplmentation()
        endpoint.method = method
        endpoint.path = path
        endpoint.baseURL = baseURL
        endpoint.paramters = parameters
        return endpoint
    }
    
}
