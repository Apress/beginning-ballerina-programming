import ballerina/http;
import ballerina/log;
import ballerina/oauth2;
 
oauth2:OutboundOAuth2Provider oauth2Provider1 = new({
    tokenUrl: "https://bitbucket.org/site/oauth2/access_token",
    clientId: "mMNWS9PLmM93V5WHjC",
    clientSecret: "jLY6xPY3ER4bNTspaGu6fb7kahhs7kUa"
});
http:BearerAuthHandler oauth2Handler1 = new(oauth2Provider1);
 
http:Client clientEP1 = new("https://api.bitbucket.org/2.0", {
    auth: {
        authHandler: oauth2Handler1
    }
});
 
public function main() {
    var response1 = clientEP1->get("/repositories/b7ademo");
    if (response1 is http:Response) {
        var result = response1.getJsonPayload();
        if (result is json) {
            var values = result.values;
            if (values is json[]) {
                var uuid = values[0].uuid;
                if (uuid is json) {
                    log:printInfo(uuid.toString());
                }
            }
        } else {
            log:printError("Failed to retrieve payload for clientEP1.");
        }
    } else {
        log:printError("Failed to call the endpoint from clientEP1.", err = response1);
    }
}
