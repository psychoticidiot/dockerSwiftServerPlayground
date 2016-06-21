import Foundation
import Kitura
import KituraSys
import KituraNet


let router = Router()

router.get("/")
{ request, response, next in
    
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    
    do
    {
        try response.status(.OK).send("Hello, World!").end()
    }
    catch
    {
        print("ERROR: Failed to send response to client: \(error)")
    }
}

let port = 8095
let server = HTTPServer.listen(port: port, delegate: router)
print("Starting server on port \(port)")
Server.run()
