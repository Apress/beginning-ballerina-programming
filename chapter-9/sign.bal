import ballerina/crypto;
import ballerina/io;

public function main(string... args) returns error? {
    string input = "Hello, World!";
    crypto:KeyStore keyStore = { 
        path: "/usr/lib/ballerina/ballerina-1.0.0/" + 
        "distributions/jballerina-1.0.0/examples/crypto/sampleKeystore.p12",
        password: "ballerina" };
    crypto:PrivateKey privateKey = check crypto:decodePrivateKey(keyStore, 
                                         "ballerina", "ballerina");
    byte[] output = check crypto:signRsaMd5(input.toBytes(), privateKey);
    io:println("Signature: ", output.toBase16());
}
