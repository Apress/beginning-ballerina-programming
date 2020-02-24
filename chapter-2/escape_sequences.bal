import ballerina/io;

public function main() {
    string message = "I remember my uncle saying \"great power comes " +
                     "great responsibility\".";
    io:println(message);
    message = "Shopping List:\n\tBread\n\tEggs\n\tButter";
    io:println(message);
}
