import ballerina/io;
import ballerina/lang.'int as ints;

public function main() returns @tainted error? {
    int a = check ints:fromString(io:readln("Enter number 1: "));
    int b = check ints:fromString(io:readln("Enter number 2: "));
    io:println(a + b);
}
