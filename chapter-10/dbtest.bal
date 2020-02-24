import ballerina/io;
import ballerinax/java.jdbc;

jdbc:Client db = new ({
    url: "jdbc:h2:file:./mydb",
    username: "user",
    password: "pass"
});

public function initTables() {
    var result = db->update("CREATE TABLE Departments (DeptId INT AUTO_INCREMENT,
                             Name VARCHAR(200), Location VARCHAR(200), 
                             PRIMARY KEY(DeptId))");
    io:println("Result: ", result);
    result = db->update("CREATE TABLE Employees (EmployeeId INT AUTO_INCREMENT, 
                         Name VARCHAR, DeptId INT, Telephone VARCHAR, 
                         PRIMARY KEY(EmployeeId), 
                         FOREIGN KEY(DeptId) REFERENCES Departments(DeptId))");
    io:println("Result: ", result);
    result = db->update("CREATE TABLE Projects (ProjId INT AUTO_INCREMENT, 
                         Name VARCHAR (200), Description VARCHAR (200), 
                         PRIMARY KEY(ProjId))");
    io:println("Result: ", result);
    result = db->update("CREATE TABLE Project_Assignments (EmployeeId INT, 
                         ProjId INT, PRIMARY KEY(EmployeeId, ProjId), 
                         FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId), 
                         FOREIGN KEY (ProjId) REFERENCES Projects(ProjId))");
    io:println("Result: ", result);
}

public function populateData() {
    var result = db->update("INSERT INTO Departments (Name, Location) 
                             VALUES ('Marketing', 'Building-1')");
    io:println("Result: ", result);
    string deptName = "Sales";
    string deptLocation = io:readln("Sales Location: ");
    result = db->update("INSERT INTO Departments (Name, Location) 
                         VALUES (?, ?)", deptName, deptLocation);
    io:println("Result: ", result);
    result = db->update("INSERT INTO Employees(Name, DeptId, Telephone) 
                         VALUES ('Will Smith', 1, 4081125918)");
    io:println("Result: ", result);
    result = db->update("INSERT INTO Employees(Name, DeptId, Telephone) 
                         VALUES ('Peter Parker', 2, 1771959901)");
    io:println("Result: ", result);
    result = db->update("INSERT INTO Projects (Name, Description) 
                         VALUES ('SaveTheWorld1', 
                         'Save the world for the first time')");
    io:println("Result: ", result);
    result = db->update("INSERT INTO Project_Assignments VALUES (1, 1)");
    io:println("Result: ", result);
    result = db->update("INSERT INTO Project_Assignments VALUES (2, 1)");
    io:println("Result: ", result);
}

type Employee record {
    int id;
    string name;
    string department;
    string telephone;
};

public function queryData() {
    table<Employee>|error result = db->select("SELECT E.EmployeeId as id, 
                            E.Name as name, D.Name AS department, 
                            E.Telephone as telephone FROM Employees E, 
                            Departments D WHERE E.DeptId = D.DeptId", 
                            Employee);
    if (result is error) {
        io:println("Error: ", result);
    } else {
        foreach var entry in result {
            io:println("ID: ", entry.id);
            io:println("Name: ", entry.name);
            io:println("Department: ", entry.department);
            io:println("Telephone: ", entry.telephone);
            io:println("=========================");
        }
    }
}

public function main() {
    initTables();
    populateData();
    queryData();
}

