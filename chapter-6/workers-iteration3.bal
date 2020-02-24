import ballerina/io;

public function main() {

    worker w1 {
        // Calculate sum(n^2)
           int n = 10000000;
           int sum = 0;
           foreach var i in 1...n {
            sum += i * i;
           }
          io:println("w1: sum of squares of first ", n,
           " positive numbers = ", sum);
   }

   worker w2 {
           // Calculate sum(n^2)
           int n = 10000000;
           int sum = 0;
           foreach var i in 1...n {
            sum += i * i;
          }
          io:println("w2: sum of squares of first ", n,
          " positive numbers = ", sum);
   }

}