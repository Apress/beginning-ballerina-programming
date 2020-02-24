import ballerina/io;
import ballerina/lang.'int as ints;

public function main() {
    while true {
        string input = io:readln("Input: ");
        int|error val = ints:fromString(input);
        if val is error {
            io:println("Invalid input, please enter again");
            continue;
        } else {
            io:println(val);
            break;
        }
    }
}