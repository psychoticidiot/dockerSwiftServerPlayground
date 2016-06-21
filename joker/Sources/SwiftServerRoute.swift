import Foundation
import Kitura
import KituraSys
import KituraNet


public protocol SwiftServerRoute
{
    var path: String { get }
    var handler: RouterHandler? { get }
}

public extension SwiftServerRoute
{
    public func registerRoute()
    {
        SwiftServer.sharedInstance.addRoute(route: self)
    }
}
