import ballerina/http;
import ballerina/io;

http:Client clientEndpoint = new("http://postman-echo.com");

public function main() {

    var response = clientEndpoint->get("/get?test=123");

    if (response is http:Response) {
        var msg = response.getJsonPayload();
        if (msg is json) {

            io:println(msg.toJsonString());
        } else {
            io:println("Invalid payload received:" , msg.reason());
        }
    } else {
        io:println("Error when calling the backend: ", response.reason());
    }
}