import ballerina/test;

@test:Config{}
function testParse1() returns error? {
    Request req = check parseRequest("sort 3 2 1");
    test:assertEquals(req.algorithm, ALGO_SORT);
    int[] rx = [3, 2, 1];
    test:assertEquals(req.data, rx);
}

@test:Config{}
function testParse2() returns error? {
    Request req = check parseRequest("sort 1");
    test:assertEquals(req.algorithm, ALGO_SORT);
    int[] rx = [1];
    test:assertEquals(req.data, rx);
}

@test:Config{}
function testParse3() returns error? {
    Request req = check parseRequest("fact 14");
    test:assertEquals(req.algorithm, ALGO_FACT);
    int[] rx = [14];
    test:assertEquals(req.data, rx);
}

@test:Config{}
function testParse4() {
    var res = parseRequest("fact");
    if res is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}

@test:Config{}
function testParse5() {
    var res = parseRequest("sort");
    if res is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}

@test:Config{}
function testParse6() {
    var res = parseRequest("sort a b 10");
    if res is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}

@test:Config{}
function testParse7() {
    var res = parseRequest("run 1 2 40");
    if res is error {
        test:assertTrue(true);
    } else {
        test:assertTrue(false);
    }
}