import ballerina/crypto;
import ballerina/io;
import ballerina/lang.'string as strings;

public function main(string... args) returns error? {
    string input = "Hello, World!";

    byte[16] key = [15, 21, 36, 11, 65, 36, 76, 28, 69, 10, 61, 32, 63, 14, 55, 6];
    byte[16] iv = [35, 25, 16, 15, 13, 16, 45, 56, 29, 15, 63, 52, 15, 44, 51, 15];
  
    byte[] encryptedData = check crypto:encryptAesCbc(input.toBytes(), key, iv);
    io:println("Encrypted Data: ", encryptedData.toBase16());
    byte[] decryptedData = check crypto:decryptAesCbc(encryptedData, key, iv);
    io:println("Decrypted Data: ", strings:fromBytes(decryptedData));
}
