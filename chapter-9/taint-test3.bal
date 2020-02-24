import ballerinax/java.jdbc;
type Student record {
    string firstname;
};
function userDefinedSecureOperation(@untainted string secureParameter) {
    // logic
}
function sanitizeAndReturnTainted(string input) returns string {
    // transform and sanitize the string here.
    return input;
}
function sanitizeAndReturnUntainted(string input) returns @untainted string {
    // transform and sanitize the string here.
    return input;
}
 
public function main(string... args) {
    jdbc:Client customerDBEP = new ({
        //JDBC config
    });
    var result = customerDBEP->
    select("SELECT firstname FROM student WHERE registration_id = " +
            "*", ());
    table<record { string firstname; }> dataTable;
    if (result is error) {
        error e = <error> result;
        panic e;
    } else {
        dataTable = result;
    }
    while (dataTable.hasNext()) {
        var jsonResult = dataTable.getNext();
        if (jsonResult is Student) {
            Student jsonData = jsonResult;
 
            userDefinedSecureOperation(jsonData.firstname);
 
           string sanitizedData1 = sanitizeAndReturnTainted(jsonData.firstname);
 
            userDefinedSecureOperation(sanitizedData1);
 
            string sanitizedData2 = sanitizeAndReturnUntainted(jsonData.firstname);
 
            userDefinedSecureOperation(sanitizedData2);
        }
    }
    checkpanic customerDBEP.stop();
    return;
}
