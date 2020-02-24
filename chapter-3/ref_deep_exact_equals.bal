import ballerina/io;

public function main() {
    map<string> m1 = { "name" : "jack"};
    map<string> m2 = { "name" : "jack"};
    io:println(m1 === m2);
    io:println(m1 == m2);
}

