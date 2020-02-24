import ballerina/io;
import ballerina/log;
 
function process(io:ReadableCharacterChannel src,
                 io:WritableCharacterChannel dst) returns error? {
    string intermediateCharacterString = " my name is ";
    string greetingText = check src.read(5);
    string name = check src.read(15);
    var writeCharResult = check dst.write(greetingText, 0);
    var writeCharResult1 = check dst.write(intermediateCharacterString, 0);
    var writeCharResult2 = check dst.write(name, 1);
    return;
}
 
function closeRc(io:ReadableCharacterChannel ch) {
    var closer = ch.close();
    if (closer is error) {
        log:printError("Error occurred while closing the channel: ", err = closer);
    }
}
 
function closeWc(io:WritableCharacterChannel ch) {
    var closer = ch.close();
    if (closer is error) {
        log:printError("Error occurred while closing the channel: ", err = closer);
    }
}

public function main() returns error? {
    io:ReadableByteChannel readableFieldResult = 
            check io:openReadableFile("./sample.txt");
    io:ReadableCharacterChannel sourceChannel = new(readableFieldResult, "UTF-8");
    io:WritableByteChannel writableFileResult = 
            check io:openWritableFile("./sampleResponse.txt");
    io:WritableCharacterChannel destinationChannel =
            new(writableFileResult, "UTF-8");
    io:println("Started to process the file.");
    var result = process(sourceChannel, destinationChannel);
    if (result is error) {
        log:printError("error occurred while processing charactors ", err = result);
    } else {
        io:println("File processing completed");
    }
    closeRc(sourceChannel);
    closeWc(destinationChannel);
}
