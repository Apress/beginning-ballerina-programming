import ballerina/stringutils;
import ballerina/lang.'int as ints;

public type Algorithm ALGO_FACT|ALGO_SORT;

# This represents the decoded calculator request from a user.
# 
# + algorithm - This represents the algorithm that was chosen
#               as an `Algorithm` type.
# + data - The data is the input data provided by the user for 
#          the given algorithm.
public type Request record {
    Algorithm algorithm;
    int[] data;
};

# This parses the request received by a user.
# 
# + request - The input by the uer
# + return - A decoded input as a `Request` value, or an `error`
# 
public function parseRequest(string request) returns Request|error {
    string trimReq = request.trim();
    if trimReq.startsWith("fact ") {
        return { algorithm: ALGO_FACT, data: 
                 check parseArray(trimReq.substring(5)) };
    } else if trimReq.startsWith("sort ") {
        return { algorithm: ALGO_SORT, data: 
                 check parseArray(trimReq.substring(5)) };
    } else {
        return error(ERROR_INVALID_REQUEST);
    }
}

function parseArray(string data) returns int[]|error {
    int[] result = [];
    string[] entries = stringutils:split(data, " ");
    foreach var entry in entries {
        var item = ints:fromString(entry);
        if item is int {
            result.push(item);
        } else {
            return error(ERROR_INVALID_REQUEST);
        }
    }
    return result;
}