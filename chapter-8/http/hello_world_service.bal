import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9090);

service hello on httpListener {
    resource function sayHello(http:Caller caller, http:Request req) {

        req.

        var result = caller->respond("Hello, World!\n");
        if (result is error) {
             log:printError("Error sending response", err = result);
        }
    }
}
