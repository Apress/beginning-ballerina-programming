import ballerina/io;

type ExamResult object {

    public string name;
    public int mathsScore;
    public int physicsScore;
    public int chemistryScore;

    public function __init(string name, int mathsScore, 
                           int physicsScore, int chemistryScore) {
        self.name = name;
        self.mathsScore = mathsScore;
        self.physicsScore = physicsScore;
        self.chemistryScore = chemistryScore;
    }

    public function average() returns int {
        return (self.mathsScore + self.physicsScore + 
                self.chemistryScore) / 3;
    }

};

public function main() returns error? {
    ExamResult result1 = new("sunil", 90, 85, 80);
    int avg = result1.average();
    io:println("Sunil's exam score average: ", avg);
}
