# Sample Swift Server Apps


## Create First App

* Install Docker

`https://docs.docker.com/docker-for-mac/`

* Install Ubuntu/Swift/Kitura Docker image

`docker pull ibmcom/kitura-ubuntu:latest`

* Run as a process and mount to local computer

`docker run -d -p 8095:8095 -v ~/Desktop/swiftserver:/root/swiftserver ibmcom/kitura-ubuntu:latest`

* Docker process

`docker ps`

* Command Line (make sure to use the container id from the command "docker ps")

`docker exec -i -t <CONTAINER_ID> /bin/bash`

* Create Project Files

`cd swiftserver`

`mkdir myFirstProject`

`cd myFirstProject`

`swift build --init`


* Create Package.swift (create file on mac in "~/Desktop/swiftserver/myFirstProject")
```swift
import PackageDescription

let package = Package(
name: "myFirstProject",
dependencies: [
.Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 15)
])
```

* Create main.swift (create file on mac in `~/Desktop/swiftserver/myFirstProject/Sources`)
```swift
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
```

* Compile & Run App

`swift build -Xcc -fblocks -Xlinker -rpath -Xlinker .build/debug`

`.build/debug/myFirstProject`





### macOS INSTALL
* Install Curl

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

`brew install curl`

* Install Toolchains

[DEVELOPMENT-SNAPSHOT-2016-05-09-a-osx](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a/swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a-osx.pkg)

[DEVELOPMENT-SNAPSHOT-2016-05-09-a-osx-symbols](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a/swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a-osx-symbols.pkg)



* Select toolchain in Xcode

Open Xcode, Preferences, Components, Toolchains, Select installed toolchain and restart

* Add swift path from terminal:
`touch ~/.bash_profile; open ~/.bash_profile`

`export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"`

`<SAVE_FILE>`

`source ~/.bash_profile`







### Stop Docker
`docker stop <NAME_FROM_DOCKER_PS>`






### RESOURCES
[Programming Languages](https://github.com/showcases/programming-languages)

[Kitura](https://github.com/IBM-Swift/Kitura)

[Perfect](http://perfect.org/)

[Zewo](http://www.zewo.io/)

[Vapor](https://github.com/qutheory/vapor)

[SwiftExpress](http://swiftexpress.io/)





### Joke Sample
http://localhost:8095/?message=Knock%20Knock

http://localhost:8095/?message=Boo!

http://localhost:8095/?message=Are%20you%20crying?
