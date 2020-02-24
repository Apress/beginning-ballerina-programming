import ballerina/io;

public function main() {
   int result1 = perm(4, 2);
   int result2 = perm(5, 3);
   io:println(result1);
   io:println(result2);
}

function perm(int n, int r) returns int {
   int x = n - r;
   int nf = fact(n);
   int xf = fact(x);
   int result = nf / xf;
   return result;
}

function fact(int n) returns int {
   int nf = 1;
   int i = n;
   while i > 0 {
       nf = nf * i;
       i = i - 1;
   }
   return nf;
}
