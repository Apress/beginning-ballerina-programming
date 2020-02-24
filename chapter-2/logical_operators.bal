import ballerina/io;

public function main() {
   int a = 10;
   int b = 20;
   int c = 10;
   boolean d = a == c && b > 10;
   boolean e = a == b || (c < 20 && c > 5);
   boolean f = a < 10;
   boolean g = !f;
   boolean h = a == c || (c < 20 && c > 5);
   boolean i = a == b && b > 10;
   io:println(d, ":", e, ":", f, ":", g, ":", h, ":", i);
}
