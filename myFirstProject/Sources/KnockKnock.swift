//
//  KnockKnock.swift
//  
//
//  Created by Brian Mullen on 6/20/16.
//
//

import Foundation
import Kitura
import KituraSys
import KituraNet

enum KnockKnockState: String
{
    case KnockKnock = "Knock, Knock",
         WhosThere = "Who's There?",
         Laugh = "HaHa"
    
    func next() -> KnockKnockState
    {
        switch(self)
        {
            case .KnockKnock:
                return .WhosThere
            case .WhosThere:
                return .Laugh
            case .Laugh:
                return .KnockKnock
        }
    }
}

public struct KnockKnockRoute: SwiftServerRoute
{
    public static var sharedInstance = KnockKnockRoute()
    public let path = "/joke"
    public var handler: RouterHandler?
    private var currentState: KnockKnockState = .KnockKnock
    
    private init()
    {
        
    }
    
    public mutating func setupHandler()
    {
        self.handler =
        { request, response, next in
            
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            
            do
            {
                let answer = self.currentState.rawValue ?? "Hmmm"
                let result = response.status(.OK).send(answer)
                self.currentState = self.currentState.next()
                try result.end()
            }
            catch
            {
                print("ERROR: Failed to send response to client: \(error)")
            }
        }
        
        self.registerRoute()
    }
}
