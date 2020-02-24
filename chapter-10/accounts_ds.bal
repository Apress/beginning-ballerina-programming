import ballerinax/java.jdbc;
import ballerina/http;

type Account record {
    int accountId = -1;
    string name;
    string nic;
    boolean savings;
    decimal balance;
    string address;
};

type TransferInfo record {
    int fromAccount;
    int toAccount;
    decimal amount;
};

jdbc:Client db = new ({
    url: "jdbc:h2:file:./accounts_db",
    username: "user",
    password: "pass"
});

type dbfield string|int|boolean|decimal;

@http:ServiceConfig {
    basePath: "accounts_ds"
}
service AccountsDS on new http:Listener(8080) {

    function sendNotFoundError(http:Caller caller, string msg) returns error? {
        http:Response resp = new;
        resp.statusCode = 404;
        resp.setPayload(msg);
        check caller->respond(resp);
    }

    resource function initDB(http:Caller caller, http:Request request) returns error? {
        _ = check db->update("CREATE TABLE ACCOUNTS (ACCOUNT_ID INT AUTO_INCREMENT, 
                                                     NAME VARCHAR(200), 
                                                     NIC VARCHAR(20),
                                                     SAVINGS BOOLEAN,
                                                     BALANCE DECIMAL,
                                                     ADDRESS VARCHAR(200),
                                                     PRIMARY KEY(ACCOUNT_ID))");
        _ = check db->update("CREATE INDEX ACCOUNTS_NIC on ACCOUNTS(NIC)");
        check caller->respond("Database Created.");
    }

    @http:ResourceConfig {
        path: "/account",
        methods: ["POST"],
        body: "account"
    }
    resource function addAccount(http:Caller caller, http:Request request, 
                                 Account account) returns error? {
        var result = check db->update("INSERT INTO ACCOUNTS (NAME, NIC, SAVINGS,
                                       BALANCE, ADDRESS) VALUES (?, ?, ?, ?, ?)",
                                       account.name, account.nic, account.savings,
                                       account.balance, account.address);
        check caller->respond({"AccountId": 
                               <int> result.generatedKeys["ACCOUNT_ID"]});
    }

    @http:ResourceConfig {
        path: "/accounts",
        methods: ["POST"],
        body: "accounts"
    }
    resource function addAccounts(http:Caller caller, http:Request request,
                                  Account[] accounts) returns error? {
        dbfield?[][] params = [];
        foreach var account in accounts {
            params[params.length()] = [account.name, account.nic, account.savings,
                                       account.balance, account.address];
        }
        var result = db->batchUpdate("INSERT INTO ACCOUNTS (NAME, NIC, SAVINGS,
                                      BALANCE, ADDRESS) VALUES (?, ?, ?, ?, ?)",
                                      false, ...params);
        check caller->respond(result.length().toString() + " account(s) added");
    }

    @http:ResourceConfig {
        path: "/account/{accountId}",
        methods: ["GET"]
    }
    resource function getAccount(http:Caller caller, http:Request request,
                                 int accountId) returns error? {
        table<Account> result = check db->select("SELECT ACCOUNT_ID as accountId,
                                                  NAME as name, NIC as nic, 
                                                  SAVINGS as savings, 
                                                  BALANCE as balance, 
                                                  ADDRESS as address 
                                                  FROM Accounts WHERE ACCOUNT_ID = ?",
                                                  Account, accountId);
        if (result.hasNext()) {
            check caller->respond(<@untainted> check json.constructFrom(
                                  result.getNext()));
        } else {
            check self.sendNotFoundError(caller, "Account not found: " + 
                                         accountId.toString());
        }
    }

    @http:ResourceConfig {
        path: "/accounts",
        methods: ["GET"]
    }
    resource function getAllAccounts(http:Caller caller, 
                                     http:Request request) returns error? {
        table<Account> result = check db->select("SELECT ACCOUNT_ID as accountId, 
                                                  NAME as name, NIC as nic, 
                                                  SAVINGS as savings, 
                                                  BALANCE as balance, 
                                                  ADDRESS as address 
                                                  FROM Accounts", Account);
        check caller->respond(<@untainted> check json.constructFrom(result));
    }

    @http:ResourceConfig {
        path: "/search",
        methods: ["GET"]
    }
    resource function getAccountByNIC(http:Caller caller, 
                                      http:Request request) returns error? {
        var nic = request.getQueryParams()["nic"];
        if (nic is string[]) {
            table<Account> result = check db->select("SELECT ACCOUNT_ID as accountId, 
                                                      NAME as name, NIC as nic, 
                                                      SAVINGS as savings, 
                                                      BALANCE as balance, 
                                                      ADDRESS as address 
                                                      FROM Accounts WHERE NIC = ?", 
                                                      Account, nic[0]);
            if (result.hasNext()) {
                check caller->respond(<@untainted> check json.constructFrom(
                                      result.getNext()));
            } else {
                check self.sendNotFoundError(caller, "Account not found with NIC: " 
                                             + nic[0]);
            }
        }
    }
    
    @http:ResourceConfig {
        path: "/account",
        methods: ["PUT"],
        body: "account"
    }
    resource function updateAccount(http:Caller caller, http:Request request,
                                    Account account) returns error? {
        var result = check db->update("UPDATE ACCOUNTS SET NAME=?, NIC=?, SAVINGS=?,
                                       BALANCE=?, ADDRESS=? WHERE ACCOUNT_ID=?", 
                                       account.name, account.nic, account.savings, 
                                       account.balance, account.address,
                                       account.accountId);
        if (result.updatedRowCount > 0) {
            check caller->respond("Account updated");
        } else {
            check self.sendNotFoundError(caller, "Account not found: " + 
                                         account.accountId.toString());
        }
    }

    @http:ResourceConfig {
        path: "/account/{accountId}",
        methods: ["DELETE"]
    }
    resource function deleteAccount(http:Caller caller, http:Request request,
                                    int accountId) returns error? {
        var result = check db->update("DELETE FROM ACCOUNTS WHERE ACCOUNT_ID=?",
                                      accountId);
        if (result.updatedRowCount > 0) {
            check caller->respond("Account deleted");
        } else {
            check self.sendNotFoundError(caller, "Account not found: " + 
                                         accountId.toString());
        }
    }

    @http:ResourceConfig {
        path: "/funds_transfer",
        methods: ["POST"],
        body: "transfer"
    }
    resource function transferFunds(http:Caller caller, http:Request request,
                                    TransferInfo transfer) returns error? {
        transaction {
            _ = check db->update("UPDATE ACCOUNTS SET BALANCE=BALANCE-? WHERE 
                                  ACCOUNT_ID = ?", transfer.amount, 
                                  transfer.fromAccount);
            _ = check db->update("UPDATE ACCOUNTS SET BALANCE=BALANCE+? WHERE 
                                  ACCOUNT_ID = ?", transfer.amount, 
                                  transfer.toAccount);
        }
        check caller->respond("Funds Transfer Successful");
    }

}