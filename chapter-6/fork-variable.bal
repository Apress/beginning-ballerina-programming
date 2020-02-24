import ballerina/io;

public function main() {
    int i = 100;
    string s = "WSO2";
    map<string> m = { "name": "Bert", "city": "New York", "postcode": "10001"};
 
    string name = <string> m["name"];
    string city = <string> m["city"];
    string postcode = <string> m["postcode"];
 
    io:println("[value type variables] before fork: " +
                   "value of integer variable is [", i, "] ",
                   "value of string variable is [", s, "]");
 
    io:println("[reference type variables] before fork: value " +
      "of name is [", name , "] value of city is [", city, "] value of " +
      "postcode is [", postcode, "]");
 
    fork {
        worker W1 {
            i = 23;
            m["name"] = "Moose";
 
            fork {
                worker W3 {
                    string street = "Wall Street";
                    m["street"] = street;
 
                    i = i + 100;
                }
            }
 
            wait W3;
        }
 
        worker W2 {
            s = "Ballerina";
            m["city"] = "Manhattan";
        }
    }
 
    _ = wait {W1, W2};
 
    io:println("[value type variables] after fork: " +
               "value of integer variable is [", i, "] ",
               "value of string variable is [", s, "]");
 
    name = <string> m["name"];
    city = <string> m["city"];
    string street = <string> m["street"];
    io:println("[reference type variables] after fork: " +
               "value of name is [", name,
               "] value of city is [", city, "] value of street is [", street,
               "] value of postcode is [", postcode, "]");
}
