import ballerina/test;

@test:Config{}
function testApp1() returns error? {
    any result = check execRequest("sort 3 2 1");
    int[] rx = [1, 2, 3];
    test:assertEquals(result, rx);
}

@test:Config{}
function testApp2() returns error? {
    any result = check execRequest("fact 3");
    test:assertEquals(result, 6);
}

@test:Config{}
function testApp3() returns error? {
    any result = check execRequest("sort 59");
    int[] rx = [59];
    test:assertEquals(result, rx);
}

@test:Config{}
function testApp4() {
    any|error result = execRequest("sort");
    if result is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}

@test:Config{}
function testApp5() {
    any|error result = execRequest("fact");
    if result is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}

