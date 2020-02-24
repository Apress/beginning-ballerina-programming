import ballerina/io;

public function main() {
    map<int> ages = { };
    ages["sunil"] = 25;
    int count = 10;
    io:println("Ages before update: ", ages);
    io:println("Count before update: ", count);
    updateAges(ages);
    updateCount(count);
    io:println("Ages after update: ", ages);
    io:println("Count after update: ", count);
}

public function updateAges(map<int> ages) {
    ages["sunil"] = 30;
    io:println("Ages in updateAges: ", ages);
}

public function updateCount(int count) {
    int myCount = count;
    myCount = 20;
    io:println("Count in updateCount: ", myCount);
}