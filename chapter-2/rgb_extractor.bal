01 import ballerina/io;
02 
03 public function main() {
04     int RED = 0x0000FF;
05     int GREEN = 0x00FF00;
06     int BLUE = 0xFF0000;
07 
08     int rgbValue = 0xAEFF01;
09     int red_component = rgbValue & RED;
10     int green_component = (rgbValue & GREEN) >> 8;
11     int blue_component = (rgbValue & BLUE) >> 16;
12     
13     io:println("R: ", red_component);
14     io:println("G: ", green_component);
15     io:println("B: ", blue_component);
16 }
17 
