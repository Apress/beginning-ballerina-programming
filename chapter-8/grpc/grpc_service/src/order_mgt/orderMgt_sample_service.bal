import ballerina/grpc;
import ballerina/log;

map<orderInfo> ordersMap = {};

listener grpc:Listener ep = new (9090);

service orderMgt on ep {

    resource function addOrder(grpc:Caller caller, orderInfo orderReq) {

        // Add the new order to the map.
        string orderId = orderReq.id;
        ordersMap[orderReq.id] = orderReq;
        // Create response message.
        string payload = "Status : Order created; OrderID : " + orderId;

        // Send response to the caller.
        error? result = caller->send(payload);
        result = caller->complete();
        if (result is error) {
            log:printError("Error from Connector: " + result.reason().toString());
        }

    }
    resource function getOrder(grpc:Caller caller, string orderId) {

        string payload = "";
        error? result = ();
        // Find the requested order from the map.
        if (ordersMap.hasKey(orderId)) {
            
            var jsonValue = json.constructFrom(ordersMap[orderId]);
            if (jsonValue is error) {
                // Send casting error as internal error.
                result = caller->sendError(grpc:INTERNAL,
                   <string>jsonValue.detail().message);
            } else {
                json orderDetails = jsonValue;
                payload = orderDetails.toString();
                // Send response to the caller.
                result = caller->send(payload);
                result = caller->complete();
            }
        } else {
            // Send entity not found error.
            payload = "Order : '" + orderId + "' cannot be found.";
            result = caller->sendError(grpc:NOT_FOUND, payload);
        }

        if (result is error) {
            log:printError("Error from Connector: " + result.reason().toString());
        }
        
    }
    resource function updateOrder(grpc:Caller caller, orderInfo value) {
        // Implementation goes here.

        // You should return a string
    }
    resource function deleteOrder(grpc:Caller caller, string value) {
        // Implementation goes here.

        // You should return a string
    }
}

