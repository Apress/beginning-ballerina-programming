import ballerinax/java.jdbc;
 
public function main(string... args) {
 
    jdbc:Client customerDBEP = new ({
        //JDBC configs
    });
   
    var result = customerDBEP->
    select("SELECT firstname FROM student WHERE registration_id = " +
            args[0], ());
    table<record { string firstname; }> dataTable;
    if (result is error) {
        error e = <error> result;
        panic e;
    } else {
        dataTable = result;
    }
}
