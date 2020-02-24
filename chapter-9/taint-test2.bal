function userDefinedSecureOperation(@untainted string secureParameter) {
    // logic
}
public function main(string... args) {
    userDefinedSecureOperation(args[0]);
}
