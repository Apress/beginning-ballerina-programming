import ballerina/io;

public function main() {
    int n = 4;
    int r = 2;
    int x = n - r;
    int nf = 1;
    int xf = 1;
    int i = n;
    while i > 0 {
        nf = nf * i;
        i = i - 1;
    }
    i = x;
    while i > 0 {
        xf = xf * i;
        i = i - 1;
    }
    int result = nf / xf;
    io:println(result);
 
    n = 5;
    r = 3;
    x = n - r;
    nf = 1;
    xf = 1;
    i = n;
    while i > 0 {
        nf = nf * i;
        i = i - 1;
    }
    i = x;
    while i > 0 {
        xf = xf * i;
        i = i - 1;
    }
    result = nf / xf;
    io:println(result);
}
