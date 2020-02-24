import ballerina/io;

public function main() {
    io:println("Worker execution started");
  
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
           // Calculate sum(n)
           int n = 10000000;
           int sum = 0;
           foreach var i in 1...n {
            sum += i;
           }
           io:println("w2: sum of first ", n, " positive numbers = ", sum);           
   }

    _ = wait {w1, w2};

    io:println("Worker execution finished");
}