//
//  SwiftServer.swift
//  
//
//  Created by Brian Mullen on 6/20/16.
//
//

import Foundation
import Kitura
import KituraSys
import KituraNet


public struct SwiftServer
{
    public static var sharedInstance = SwiftServer(port: 8095)
    
    private let port: Int
    private let router = Router()
    private var routes = [SwiftServerRoute]()
    private var server: HTTPServer?
    
    private init(port: Int)
    {
        self.port = port
    }
    
    public mutating func start()
    {
        for route in routes
        {
            guard let handler = route.handler else { continue }
            
            router.get(route.path, handler: handler)
        }
        
        server = HTTPServer.listen(port: port, delegate: router)
        print("Starting server on port \(port)")
        Server.run()
    }
    
    public mutating func addRoute(route: SwiftServerRoute)
    {
        routes.append(route)
    }
}
