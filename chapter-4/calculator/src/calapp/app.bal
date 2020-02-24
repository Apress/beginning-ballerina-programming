import ballerina/io;
import laf/calparser;
import laf/calfunctions;

public function main() returns error? {
    string input = io:readln("Enter calculator request: ");
    var result = check execRequest(input);
    io:println("Result: ", result);
}

public function execRequest(string input) returns any|error {
    calparser:Request request = check calparser:parseRequest(input);
    if request.algorithm == calparser:ALGO_FACT {
        return calfunctions:fact(request.data[0]);
    } else if request.algorithm == calparser:ALGO_SORT {
        return calfunctions:sort(request.data);
    } else {
        return error("Unknown algorithm");
    }
}