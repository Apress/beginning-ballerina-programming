import ballerina/io;
const FILE_NOT_FOUND_ERROR = "FILE_NOT_FOUND_ERROR";
const EOF_ERROR = "EOF_ERROR";
const FILE_ACCESS_ERROR = "FILE_ACCESS_ERROR";
type FILE_ERROR FILE_NOT_FOUND_ERROR|EOF_ERROR|FILE_ACCESS_ERROR;

type FileNotFoundError error<FILE_NOT_FOUND_ERROR>;
type EOFError error<EOF_ERROR>;
type FileAccessError error<FILE_ACCESS_ERROR>;
type FileError error<FILE_ERROR>;

const ROUTING_ERROR = "ROUTING_ERROR";
const CONNECTION_ERROR = "CONNECTION_ERROR";
type NETWORK_ERROR ROUTING_ERROR|CONNECTION_ERROR;
type IO_ERROR FILE_ERROR|NETWORK_ERROR;

type RoutingError error<ROUTING_ERROR>;
type ConnectionError error<CONNECTION_ERROR>;
type NetworkError error<NETWORK_ERROR>;
type IOError error<IO_ERROR>;

public function main() {
    var result = readFile("file1");
    if (result is EOFError) {
        io:println("EOFError: ", result);
    } else if (result is FileNotFoundError) {
        io:println("FileNotFoundError: ", result);
    }
    result = writeFile("file2", "data");
    if (result is FileError) {
        io:println("FileError: ", result);
    }
    result = writeFile("file3", "data");
    if (result is IOError) {
        io:println("IOError: ", result);
    }
}

function readFile(string fname) returns byte[]|error {
    return error(EOF_ERROR);
}

function writeFile(string fname, string data) returns byte[]|error {
    return error(FILE_NOT_FOUND_ERROR);
}