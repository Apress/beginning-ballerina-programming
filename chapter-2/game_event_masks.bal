import ballerina/io;

public function main() {
    int UP = 1;     // [0 0 0 0 0 0 0 1]
    int DOWN = 2;   // [0 0 0 0 0 0 1 0]
    int LEFT = 4;   // [0 0 0 0 0 1 0 0]
    int RIGHT = 8;  // [0 0 0 0 1 0 0 0]
    int JUMP = 16;  // [0 0 0 1 0 0 0 0]
    int SHOOT = 32; // [0 0 1 0 0 0 0 0]

    int event = RIGHT | JUMP | SHOOT; // creating the event
    if ((event & UP) == UP) {
        io:println("UP");
    }
    if ((event & DOWN) == DOWN) {
        io:println("DOWN");
    }
    if ((event & LEFT) == LEFT) {
        io:println("LEFT");
    }
    if ((event & RIGHT) == RIGHT) {
        io:println("RIGHT");
    }
    if ((event & JUMP) == JUMP) {
        io:println("JUMP");
    }
    if ((event & SHOOT) == SHOOT) {
        io:println("SHOOT");
    }
}
