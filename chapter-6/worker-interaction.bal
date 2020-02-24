import ballerina/io;
import ballerina/runtime;
 
public function main() {
    worker w1 {
        int iw1 = 50;
        float kw1 = 7.67;
        [int, float] x1 = [iw1, kw1];
        x1 -> w2;
        io:println("[w1 -> w2] iw1: ", iw1, " kw1: ", kw1);
 
        json jw1 = {};
        jw1 = <- w2;
        string jStr = jw1.toString();
        io:println("[w1 <- w2] jw1: ", jStr);
        io:println("[w1 ->> w2] iw1: ", iw1);
 
        () send = iw1 ->> w2;

        io:println("[w1 ->> w2] successful!!");

        io:println("[w1 -> w3] kw1: ", kw1);
        kw1 -> w3;
        kw1 -> w3;
        kw1 -> w3;

        io:println("Waiting for worker w3 to fetch messages..");

        error? flushResult = flush w3;
        io:println("[w1 -> w3] Flushed!!");
    }
 
    worker w2 {
        int iw2;
        float kw2;
        [int, float] vW1 = [0, 1.0];
        vW1 = <- w1;
        [iw2, kw2] = vW1;
        io:println("[w2 <- w1] iw2: ", iw2 , " kw: ", kw2);

        json jw2 = { "greet": "Hello World" };
        io:println("[w2 -> w1] jw2: ", jw2);
        jw2 -> w1;

        int lw2;
        runtime:sleep(5);
        lw2 = <- w1;
        io:println("[w2 <- w1] lw2: ", lw2);
    }

    worker w3 {
        float mw;

        runtime:sleep(50);
        mw = <- w1;
        mw = <- w1;
        mw = <- w1;
        io:println("[w3 <- w1] mw: ", mw);
    }

    wait w1;
}
