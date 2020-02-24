import ballerina/io;

public function main() {
    int a = 5;
    int b = 9;
    int c = a & b;
    int d = a | b;
    io:println(c, ":", d);
    int e = 16 >> 1;
    int f = -10;
    int g = f >> 1;
    int h = f >>> 1;
    int i = f << 2;
    io:println(e, ":", g, ":", h, ":", i);
}
