import ballerina/io;

public function main() {
    foreach int i in 0..<99 {
        io:println(i);
    }
    io:println("End.");
}