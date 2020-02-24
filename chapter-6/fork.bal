import ballerina/io;

public function main() {

    fork {
        worker w1 returns [int, string] {
            int i = 23;
            string s = "Colombo";
            io:println("[w1] i: ", i, " s: ", s);
            // Return of worker `w1`.
            return [i, s];
        }
 
        worker w2 returns float {
            float f = 10.344;
            io:println("[w2] f: ", f);
            // Return of worker `w2`.
            return f;
        }
    }
 
    record{ [int, string] w1; float w2; } results = wait {w1, w2};
 
    var [iW1, sW1] = results.w1;
    var fW2 = results.w2;
    io:println("[main] iW1: ", iW1, " sW1: ", sW1, " fW2: ", fW2);
}
