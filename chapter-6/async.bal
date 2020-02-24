    future<int> f1 = start sum(40, 50);

    int result = squarePlusCube(f1);

    _ = wait f1;
    io:println("SQ + CB = ", result);

    future<()> f2 = start countInfinity();
    f2.cancel();


    future<http:Response | error> f3 = start clientEndpoint-> get("/get?test=123");

    http:Response | error response = wait f3;

    if (response is http:Response) {
        io:println(response.getJsonPayload());
    } else {
        io:println(response.reason());
    }