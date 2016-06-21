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
    private var answer = ""
    
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
                let message = request.queryParams["message"]?.stringByRemovingPercentEncoding ?? ""
                
                if message.lowercased() == "knock knock"
                {
                    self.currentState = .KnockKnock
                }
                
                switch(self.currentState)
                {
                    case .KnockKnock:
                        self.answer = message + "\nWho's There?\n"
                    case .WhosThere:
                        self.answer += message + "\n" + message + " who?\n"
                    case .Laugh:
                        self.answer += message + "\nHaHa! That was a good one!"
                }
                self.currentState = self.currentState.next()
                
                try response.status(.OK).send(self.answer).end()
            }
            catch
            {
                print("ERROR: Failed to send response to client: \(error)")
            }
        }
        
        self.registerRoute()
    }
}
