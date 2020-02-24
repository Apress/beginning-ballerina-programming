import ballerina/http;
import ballerina/jwt;
import ballerina/log;
 
jwt:InboundJwtAuthProvider jwtAuthProvider = new({
    issuer: "ballerina",
    audience: "ballerina.io",
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});
 
http:BearerAuthHandler jwtAuthHandler = new(jwtAuthProvider);
 
listener http:Listener securedEPwithJWT = new(9443, config = {
    auth: {
        authHandlers: [jwtAuthHandler]
    },
    // The secure hello world sample uses HTTPS.
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});
 
service hello on securedEPwithJWT {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/",
        auth: {
            scopes: ["hello"],
            enabled: true
        }
    }
    resource function hello(http:Caller caller, http:Request req) {
        error? result = caller->respond("Hello, World!!!");
        if (result is error) {
            log:printError("Error in responding to caller", err = result);
        }
    }
}
