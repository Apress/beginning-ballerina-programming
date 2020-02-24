import ballerina/crypto;
import ballerina/io;
 
public function main(string... args) returns error? {
    string input = "Hello, World!";
    string key = "mysecret";
    byte[] output = crypto:hmacMd5(input.toBytes(),
                                   key.toBytes());
    io:println("HMAC: ", output.toBase16());
}
