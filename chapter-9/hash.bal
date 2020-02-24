import ballerina/crypto;
import ballerina/io;

public function main(string... args) returns error? {
    string input = "Hello, World!";
    byte[] hash = crypto:hashSha1(input.toBytes());
    io:println("SHA1: ", hash.toBase16());
}
