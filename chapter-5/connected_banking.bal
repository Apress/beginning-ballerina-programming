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

type OnlineBankingTransferErrorDetail record {|
    string message?;
    AccountMgtError cause;
    string sourceAccount;
    string targetAccount;
    decimal amount;
|};

const OB_TRANSFER_ERROR = "ONLINE_BANKING_TRANSFER_ERROR";

type OnlineBankingTransferError error<OB_TRANSFER_ERROR,
                                OnlineBankingTransferErrorDetail>;

type OnlineBanking object {

    private AccountManager accountMgr;

    public function __init(AccountManager accountMgr) {
        self.accountMgr = accountMgr;
    }

    public function lookupAccountBalance(string accountNumber) 
                                     returns decimal|AccountMgtError {
        return self.accountMgr.getAccountBalance(accountNumber);
    }

    public function transferMoney(string sourceAccount, 
                                  string targetAccount, 
                                  decimal amount) 
                                  returns OnlineBankingTransferError? {
        AccountMgtError? err = self.accountMgr.debitAccount(
                                  sourceAccount, amount);
        if err is error {
            return error(OB_TRANSFER_ERROR, 
                         sourceAccount = sourceAccount, 
                         targetAccount = targetAccount, 
                         amount = amount, cause = err);
        }
        err = self.accountMgr.creditAccount(targetAccount, amount);
        if err is error {
            return error(OB_TRANSFER_ERROR, 
                         sourceAccount = sourceAccount, 
                         targetAccount = targetAccount, 
                         amount = amount, cause = err);
        }
    }

};

public function main() {
    AccountManager actMgmr = new;
    OnlineBanking olBank = new(actMgmr);
    error? err = olBank.transferMoney("AC1", "AC2", 500.0);
    if err is error {
        io:println("AC1->AC2 Transfer Error: ", err);
    }
    io:println("AC1 Balance: ", olBank.lookupAccountBalance("AC1"));
    io:println("AC2 Balance: ", olBank.lookupAccountBalance("AC2"));
    err = olBank.transferMoney("AC1", "AC2", 1500.0);
    if err is error {
        io:println("AC1->AC2 Transfer Error: ", err);
    }
}