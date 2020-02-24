import ballerina/log;
import ballerina/grpc;

// This is client implementation for unary blocking scenario
public function main(string... args) {
    // Client endpoint configuration
        orderMgtBlockingClient orderMgtBlockingEp = new("http://localhost:9090");

    // Add an order
    log:printInfo("-----------------------Add a new order-----------------------");
    orderInfo orderReq = {id:"100500", name:"XYZ", description:"Sample order."};
    var addResponse = orderMgtBlockingEp->addOrder(orderReq);
    if (addResponse is error) {
        log:printError("Error from Connector: " + addResponse.reason().toString());
    } else {
        string result;
        grpc:Headers resHeaders;
        [result, resHeaders] = addResponse;
        log:printInfo("Response - " + result + "\n");
    }

    // Get an order
    log:printInfo("-------------------Get an existing order---------------------");
    var getResponse = orderMgtBlockingEp->getOrder("100500");
    if (getResponse is error) {
        log:printError("Error from Connector: " + getResponse.reason().toString());
    } else {
        string result;
        grpc:Headers resHeaders;
        [result, resHeaders] = getResponse;
        log:printInfo("Response - " + result + "\n");
    }
}
