import ballerina/io;

type MyReason "CODE1"|"CODE2";

type MyErrorDetail record {|
    string message?;
    error cause?;
    string location;
|};

type MyError error<MyReason, MyErrorDetail>;

public function main() {
    string|error res = trap myErrorProneFunction();
    if res is error {
        io:println("Error: ", res);
    } else {
        io:println(res);
    }
}

function myErrorProneFunction() returns string {
    myPanicFunction();
    return "response";
}

function myPanicFunction() {
    MyError err = error("CODE1", location = "L1");
    panic err;
}
