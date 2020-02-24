import ballerina/io;
import ballerina/lang.'int as ints;

public function main() {
    string input = io:readln("Input: ");
    int|error val = ints:fromString(input);
    if val is error {
        io:println("Reason: ", val.reason());
        io:println("Detail: ", val.detail());
        io:println("Stacktrace: ", val.stackTrace().callStack);
        io:println("ToString: ", val.toString());
    } else {
        io:println(val);
    }
}