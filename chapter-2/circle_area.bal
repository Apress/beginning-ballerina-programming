import ballerina/io;

public function main() {
    int radius = 5;
    float area = 3.1415 * radius * radius;
    io:println(area);
}
