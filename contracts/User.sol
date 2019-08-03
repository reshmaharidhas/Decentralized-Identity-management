pragma solidity^0.5.5;
import "browser/Govtorg.sol";
import "browser/Base.sol";
contract User is Govtorg {
    string public user_FullName;
    uint public user_Age;
    string public user_Dob;
    string public user_HouseAddr;
    uint public user_MobileNum;
    uint public user_AadhaarNum;
    uint public doc1;
    uint public doc2;
    string public testStr;
    modifier onlySignedInUser {
        require(userLoginStatus[msg.sender]==1);
        _;
    }
    function registerUser(string memory _userEmailId, string memory _userpassword, 
    string memory _userFullName,uint _age,string memory _dateOfBirth,
    string memory _userHouseAddr,uint _mobileNumber,uint _aadharNum) public {
       require(userRegisteredStatus[_userEmailId]==0);
       require(userRegisterStatus[msg.sender]==0);
       require(govtorgRegisterStatus[msg.sender]==0);
       userDetails[msg.sender] = User(_userEmailId,_userpassword,_userFullName,_age,_dateOfBirth,_userHouseAddr,_mobileNumber,_aadharNum);
       addUserLogin(_userEmailId,_userpassword);
       matchAddrToEmail[msg.sender] = _userEmailId;
       userRegisteredStatus[_userEmailId] = 1;
       userRegisterStatus[msg.sender] = 1;
       usersCount++;
    }
    function addUserLogin(string memory _addUserName, string memory _addUserPassword) public {
        userLogin[msg.sender] = UsersLoginIDs(_addUserName,_addUserPassword);
    }
    function signinUser(string memory _username, string memory _userpassword) public {
        require(keccak256(abi.encodePacked(matchAddrToEmail[msg.sender]))==keccak256(abi.encodePacked(_username)));
        require(keccak256(abi.encodePacked(userLogin[msg.sender].userp))==keccak256(abi.encodePacked(_userpassword)));
        require(userLoginStatus[msg.sender]==0);
        userLoginStatus[msg.sender] = 1;
    }
    function showUserDetails() public {
        require(userLoginStatus[msg.sender] == 1);
        user_FullName = userDetails[msg.sender].userFullName;
        user_Age = userDetails[msg.sender].age;
        user_Dob = userDetails[msg.sender].dateOfBirth;
        user_HouseAddr = userDetails[msg.sender].userHouseAddress;
        user_MobileNum = userDetails[msg.sender].mobileNumber;
        user_AadhaarNum = userDetails[msg.sender].aadharNum;
    }
    function showUserFullname() public view returns(string memory) {
        return user_FullName;
    }
    function showUserAge() public view returns(uint){
        return user_Age;
    }
    function showUserDob() public view returns(string memory){
        return user_Dob;
    }
    function showUserHouseAddr() public view returns(string memory){
        return user_HouseAddr;
    }
    function showUserMobileNum() public view returns(uint){
        return user_MobileNum;
    }
    function showUserAadhaarNum() public view returns(uint){
        return user_AadhaarNum;
    }
    function addAadhaarDoc(string memory regNum) public onlySignedInUser{
        myDocuments[msg.sender][1]=FileDoc(1,"aadhaar",regNum,false);
    }
    function getAadhaarDoc(address userAddress) public {
        testStr = myDocuments[userAddress][1].regUniqueNum;
    }
    function addBirthCertDoc(string memory regNum) public onlySignedInUser{
        myDocuments[msg.sender][2]=FileDoc(2,"birthcert",regNum,false);
    }
    function getBirthCertDoc(address userAddress) public {
        testStr = myDocuments[userAddress][2].regUniqueNum;
    }
    function getTestStr() public view returns(string memory) {
        return testStr;
    }
    function getUsersCount() public view returns(uint) {
        return usersCount;
    }
    function getRequestedInfo(address requester) public onlySignedInUser {
        doc1 = docsRequestedDB[msg.sender][requester].aadhaarproof;
        doc2 = docsRequestedDB[msg.sender][requester].birthproof;
    }
    function getOrgDetails(uint n) public onlySignedInUser {
        address nn = getOrgAt(n);
        getRequestedInfo(nn);
    }
    function getOrgNameAt(uint num) public view returns(string memory){
        address x = getOrgAt(num);
        return govtorgDetails[x].govtOrgName;
    }
    function getDoc1() public view returns(uint) {
        return doc1;
    }
    function getDoc2() public view returns(uint) {
        return doc2;
    }
    
    function setPermissionDoc1(address req_address,uint z) public onlySignedInUser{
        _docs_permitted[msg.sender][req_address].aadhaarproof = z;
        _docs_permitted_tb[req_address][msg.sender].aadhaarproof = z;
    }
    function setPermissionDoc2(address req_address,uint z) public onlySignedInUser{
        _docs_permitted[msg.sender][req_address].birthproof = z;
        _docs_permitted_tb[req_address][msg.sender].birthproof = z;
    }
    function getPermissionDoc1(address req_address) public onlySignedInGovtOrg {
        d1 = _docs_permitted_tb[msg.sender][req_address].aadhaarproof;
    }
    function getPermissionDoc2(address req_address) public onlySignedInGovtOrg {
        d2 = _docs_permitted_tb[msg.sender][req_address].birthproof;
    }  
}