import ballerina/crypto;
import ballerina/io;
import ballerina/lang.'string as strings;
 
public function main(string... args) returns error? {
    string input = "Hello, World!";
    crypto:KeyStore keyStore = { path: "/usr/lib/ballerina/ballerina-1.0.0" + 
                                 "-alpha/examples/crypto/sampleKeystore.p12",
                                 password: "ballerina" };
    crypto:PrivateKey privateKey = check crypto:decodePrivateKey(keyStore,
                                         "ballerina", "ballerina");
    crypto:PublicKey publicKey = check crypto:decodePublicKey(keyStore, 
                                         "ballerina");
    byte[] output = check crypto:encryptRsaEcb(input.toBytes(), publicKey);
    io:println("RSA Public Key Encrypted Data: ", output.toBase16());
    output = check crypto:decryptRsaEcb(output, privateKey);
    io:println("RSA Private Key Decrypted Data: ", strings:fromBytes(output));
}

