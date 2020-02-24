import ballerina/io;

public function main() {
    int a = 10;
    int b = 20;
    int c = 10;
    boolean d = a == c;
    boolean e = a == b;
    boolean f = a < 10;
    boolean g = a <= 10;
    io:println(d, ":", e, ":", f, ":", g);
}
