import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/"
}
service hello on new http:Listener(9090) {

    @http:ResourceConfig {
        path: "/",
        methods: ["POST"]
    }
    resource function sayHello(http:Caller caller, http:Request req) {

        http:Response res = new;

        var payload = req.getTextPayload();

        if (payload is error) {
            log:printError("Error retrieving request", err = payload);
        } else {
            var result = caller->respond("Hello, " + <@untainted> payload + "!\n");
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        } 
    }
}