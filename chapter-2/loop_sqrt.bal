import ballerina/io;
import ballerina/math;
import ballerina/lang.'float as floats;

public function main() returns error? {
  while true {
    string input = io:readln("Enter a positive number (q to exit): ");
    if input == "q" {
        break;
    }
    float n = check floats:fromString(input);
    if n < 0 {
        io:println("Not a positive number, try again.");
        continue;
    }
    io:println(math:sqrt(n));
  }
}
