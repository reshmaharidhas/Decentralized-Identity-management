pragma solidity^0.5.5;
contract Base {
    address public owner;
      
    mapping(address=>User) public userDetails;  
    mapping(address=>UsersLoginIDs) public userLogin;
    mapping(address=>string) public matchAddrToEmail;
    mapping(string=>uint) public userRegisteredStatus;
    mapping(address=>uint) public userLoginStatus;
    mapping(address=>uint) public userRegisterStatus;
    
    mapping(address=>GovtOrgLoginIDs) public govtorgLogin;
    mapping(string=>uint) public govtorgRegisteredStatus;
    mapping(address=>uint) public govtorgRegisterStatus;
    mapping(address=>uint) public govtorgLoginStatus;
    mapping(address=>mapping(uint=>FileDoc)) public myDocuments;
    mapping(address=>mapping(address=>DocsRequestedDatabase)) public docsRequestedDB;
    mapping(address=>mapping(address=>DocsRequestedDatabase)) public _docs_permitted;
    mapping(address=>mapping(address=>DocsRequestedDatabase)) public _docs_permitted_tb;
    
    uint public gov;
    mapping(uint=>address) public govtOrgsList;
    
    uint public usersCount;
    uint public govtorgsCount;
    constructor() public{
        owner = msg.sender;
        gov = 0;
    }
    modifier onlyOwner {
        require(msg.sender==owner);
        _;
    }
    
    struct UsersLoginIDs {
        string usern;
        string userp;
    }
    struct GovtOrgLoginIDs {
        string usern;
        string userp;
    }
   
    struct FileDoc{
        uint id;
        string fileDocName;
        string regUniqueNum;
        bool initialVerification;
    }
    struct DocsRequestedDatabase{
        uint aadhaarproof;
        uint birthproof;
    }
    struct User {
        string userEmailId;
        string userpassword;
        string userFullName;
        uint age;
        string dateOfBirth;
        string userHouseAddress;
        uint mobileNumber;
        uint aadharNum;
    }
    function getOrgAt(uint num) public view returns(address) {
        address at = govtOrgsList[num];
        return at;
    }
    function logout() public {
        if(userLoginStatus[msg.sender]==1){
            userLoginStatus[msg.sender]=0;
        }
        else if(govtorgLoginStatus[msg.sender]==1){
        govtorgLoginStatus[msg.sender] = 0;
        }
    }
   
}
