import ballerina/io;
import ballerina/time;

const INVALID_ACCOUNT_NUMBER = "INVALID_ACCOUNT_NUMBER";
const INSUFFICIENT_ACCOUNT_BALANCE = "INSUFFICIENT_ACCOUNT_BALANCE";

type AccountMgtErrorReason INVALID_ACCOUNT_NUMBER | 
                           INSUFFICIENT_ACCOUNT_BALANCE;

type AccountMgtErrorDetail record {|
    string message?;
    error cause?;
    int time;
    string account;
|};

type AccountMgtError error<AccountMgtErrorReason, 
                           AccountMgtErrorDetail>;

public type AccountManager object {

    private map<decimal> accounts = { AC1: 1500.0, AC2: 2550.0 };

    public function getAccountBalance(string accountNumber) 
                                      returns decimal|AccountMgtError {
        decimal? result = self.accounts[accountNumber];
        if result is decimal {
            return result;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function debitAccount(string accountNumber, decimal amount) 
                                 returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if result is decimal {
            decimal balance = result - amount;
            if (balance < 0.0) {
                return error(INSUFFICIENT_ACCOUNT_BALANCE, 
                             time = time:currentTime().time,
                             account = accountNumber);
            } else {
                self.accounts[accountNumber] = balance;
            }
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function creditAccount(string accountNumber, decimal amount) 
                                  returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if result is decimal {
            self.accounts[accountNumber] = result + amount;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time,
                         account = accountNumber);
        }
    }

};

public function main() {
    AccountManager am = new;
    decimal|error r1 = am.getAccountBalance("AC1");
    decimal|error r2 = am.getAccountBalance("AC2");
    decimal|error r3 = am.getAccountBalance("AC3");
    io:println("AC1 Balance: ", r1);
    io:println("AC2 Balance: ", r2);
    io:println("AC3 Balance: ", r3);
    error? err = am.debitAccount("AC1", 1000);
    if (err is error) {
        io:println("AC1 Debit Error: ", err);
    }
    err = am.creditAccount("AC2", 1000);
    if (err is error) {
        io:println("AC2 Credit Error: ", err);
    }
    io:println("AC1 Balance: ", am.getAccountBalance("AC1"));
    io:println("AC2 Balance: ",  am.getAccountBalance("AC2"));
    err = am.debitAccount("AC1", 1000);
    if (err is error) {
        io:println("AC1 Debit Error: ", err);
    }
}
