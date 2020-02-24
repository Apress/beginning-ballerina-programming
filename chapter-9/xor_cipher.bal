import ballerina/io;
import ballerina/lang.'int as ints;

public function main(string... args) returns error? {
    string fileIn = args[0];
    string fileOut = args[1];
    byte key = <byte> check ints:fromString(args[2]);
    io:ReadableByteChannel srcCh = check io:openReadableFile(
                                            <@untainted> fileIn);
    io:WritableByteChannel targetCh = check io:openWritableFile(
                                            <@untainted> fileOut);
    while (true) {
        var result = srcCh.read(100);
        if (result is io:EofError) {
            break;
        } else {
            check writeFully(targetCh, xor(check result, key));
        }
    }
    check srcCh.close();
    check targetCh.close();
}

public function xor(byte[] data, byte key) returns byte[] {
    byte[] result = [];
    int i = 0;
    while i < data.length() {
        result[i] = data[i] ^ key;
        i += 1;
    }
    return result;
}

public function writeFully(io:WritableByteChannel targetCh, byte[] data) 
                           returns error? {
    int written = 0;
    int count = data.length();
    while (written < count) {
        written += check targetCh.write(data, written);
    }
}