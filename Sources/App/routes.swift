import Vapor
import MongoKitten
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    let server = try Server("mongodb://heroku_f46qcxzm:b384h2tgf844hh2l3rs4f5hd2v@ds123603.mlab.com:23603/heroku_f46qcxzm")
    let database = server["heroku_f46qcxzm"]
    if server.isConnected {
        MongoClient(database: database)
        _ = ProductController(router: router)
        print("Connected successfully to server")
    }
     _ = ProductController(router: router)
    //var success = TokenStore().fetchToken()
    //print(success)
    router.get { req in
        return try req.view().render("Landing.html")
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        
        return "Hello, world!"
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
