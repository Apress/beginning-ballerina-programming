import ballerina/http;
import ballerina/log;
import ballerina/auth;

auth:InboundBasicAuthProvider basicAuthProvider = new;
http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);

listener http:Listener secureBasicAuthEP = new(9443, config = {
    auth: {
        authHandlers: [basicAuthHandler]
    },
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    basePath: "/hello",
    auth: {
        scopes: ["scope1"]
    }
}
service hello on secureBasicAuthEP {
 
    @http:ResourceConfig {
        methods: ["GET"],
        auth: {
            scopes: ["scope2"]
        }
    }
    resource function hi(http:Caller caller, http:Request req) {
        var result = caller->respond("Hi Greetings!!!\n");
        if (result is error) {
            log:printError("Error in responding to caller", err = result);
        }
    }
    resource function bye(http:Caller caller, http:Request req) {
        var result = caller->respond("Bye Greetings!!!\n");
        if (result is error) {
            log:printError("Error in responding to caller", err = result);
        }
    }
}
