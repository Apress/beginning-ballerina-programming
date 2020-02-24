import ballerina/io;

public function main() {
    int i = 0;
    // io:println(count);
    int count = 10;
    while i < count {
        io:println(i);
        int j = i + 1;
        io:println(j);
        if (j > 5) {
            int x = j * 2;
            io:println(x);
        }
        i += 1;
    }
    // io:println(j);
}

