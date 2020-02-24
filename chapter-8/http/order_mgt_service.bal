import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9090);

// Order management is done using an in-memory map.
map<json> ordersMap = {};

// RESTful service.
@http:ServiceConfig { basePath: "/" }
service orderMgt on httpListener {

    // Resource that handles the HTTP POST requests that are directed to the path
    // '/order' to create a new Order.
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/order"
    }
    resource function addOrder(http:Caller caller, http:Request req) {
        http:Response response = new;
        var orderReq = req.getJsonPayload();
        if (orderReq is json) {
            json | error idJ = orderReq.Order.ID;
            if idJ is error {
                log:printError("Error extracting order ID", err = idJ);
            } else {
                string orderId = idJ.toString(); 
                ordersMap[orderId] = orderReq;
                // Create response message.
                json payload = { status: "Order Created.", orderId: orderId };
                response.setJsonPayload(<@untainted> payload);
                // Set 201 Created status code in the response message.
                response.statusCode = 201;
                // Set 'Location' header in the response message.
                // This can be used by the client to locate the newly added order.
                response.setHeader("Location",
                    "http://abc.retail.com:9090/ordermgt/order/" + orderId);
            }
        } else {
            response.statusCode = 400;
            response.setPayload("Invalid payload received");
        }
        // Send response to the client.
        var result = caller->respond(response);
        if (result is error) {
            log:printError("Error sending response", err = result);
        }
    }

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/order/{orderId}"
    }
    resource function getOrder(http:Caller caller, http:Request req, string orderId) {
       // Find the requested order from the map and retrieve it in JSON format.
       json? payload = ordersMap[orderId];
       http:Response response = new;
       if (payload == null) {
           payload = "Order : " + orderId + " cannot be found.";
       }    
       // Set the JSON payload in the outgoing response message.
       response.setJsonPayload(<@untainted> payload);
      // Send response to the client.
      var result = caller->respond(response);
      if (result is error) {
          log:printError("Error sending response", err = result);
      }
    }

    @http:ResourceConfig {
        methods: ["PUT"],
        path: "/order/{orderId}"
    }
    resource function updateOrder(http:Caller caller, http:Request req, string orderId)  {
       // Implementation
    }

    @http:ResourceConfig {
        methods: ["DELETE"],
        path: "/order/{orderId}"
    }
    resource function deleteOrder(http:Caller caller, http:Request req, string orderId) {
        // Implementation
    }
    
}
