import ballerina/io;

type Animal abstract object {

    public string name;
    public string class;

    public function sound() returns string;

};

type Dog object {

    public string name = "Dog";
    public string class = "Mammal";

    public function sound() returns string {
        return "bark";
    }

};

type Owl object {

    public string name = "Owl";
    public string class = "Bird";

    public function sound() returns string {
        return "hoot";
    }

};

function printAnimal(Animal animal) {
    io:println("Animal name: ", animal.name, ", class: ", 
               animal.class, ", sound: ", animal.sound());
}

public function main() {
    printAnimal(new Dog());
    printAnimal(new Owl());
}

