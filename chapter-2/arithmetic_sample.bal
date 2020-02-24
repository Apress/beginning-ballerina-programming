import ballerina/io;

public function main() {
    int a = 1 + 4;
    int b = a + 10;
    float c = b * 2.5;
    io:println(a, ":", b, ":", c);
    int d = a % 3;
    int e = a / 3;
    io:println(d, ":", e);
    float f = a / 3.0;
    io:println(f);
    int g = a + b * 2;
    int h = (a + b) * 2;
    io:println(g, ":", h);
}
