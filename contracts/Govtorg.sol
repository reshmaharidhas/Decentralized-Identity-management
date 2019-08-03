pragma solidity^0.5.5;
import "browser/Base.sol";
contract Govtorg is Base {
    mapping(address=>GovtOrg) public govtorgDetails;
    string public govorg_Name;
    string public govorg_IdNum;
    string public govorg_Location;
    string public govorg_HQ;
    uint public govorg_ContactNum;
    uint public govorg_UserRequestedCount;
    
    uint public d1;
    uint public d2;
    
    modifier onlySignedInGovtOrg {
        require(govtorgLoginStatus[msg.sender]==1);
        _;
    }
    struct GovtOrg {
        string govtOrgEmailId;
        string govtOrgPassword;
        string govtOrgName;
        string govtOrgIdNum;
        string govtOrgLocation;
        string govtOrgHeadQuarters;
        uint govtOrgContactNum;
        
    }
    function registerGovtOrg(string memory _govtOrgEmailId, string memory _govtOrgPassword,
        string memory _govtOrgName,string memory _govtOrgIdNum,string memory _govtOrgLocation,
        string memory _govtOrgHeadQuarters,uint _govtOrgContactNum) public{
        require(govtorgRegisteredStatus[_govtOrgEmailId]==0);
        require(govtorgRegisterStatus[msg.sender]==0);
        require(userRegisterStatus[msg.sender]==0);
        govtorgDetails[msg.sender] = GovtOrg(_govtOrgEmailId,_govtOrgPassword,_govtOrgName,_govtOrgIdNum,_govtOrgLocation,_govtOrgHeadQuarters,_govtOrgContactNum);
        addGovtLogin(_govtOrgEmailId,_govtOrgPassword);
        matchAddrToEmail[msg.sender] = _govtOrgEmailId;
        govtorgRegisteredStatus[_govtOrgEmailId] = 1;
        govtorgRegisterStatus[msg.sender] = 1;
        gov++;
        govtOrgsList[gov] = msg.sender;
        govtorgsCount++;
    }
    function addGovtLogin(string memory _addGovtorgEmailid, string memory _addGovtorgPassword) public{
        govtorgLogin[msg.sender] = GovtOrgLoginIDs(_addGovtorgEmailid,_addGovtorgPassword);
    }
    function signinGovtorg(string memory _govorgname, string memory _govorgpassword) public {
        require(keccak256(abi.encodePacked(matchAddrToEmail[msg.sender]))==keccak256(abi.encodePacked(_govorgname)));
        require(keccak256(abi.encodePacked(govtorgLogin[msg.sender].userp))==keccak256(abi.encodePacked(_govorgpassword)));
        require(govtorgLoginStatus[msg.sender]==0);
        govtorgLoginStatus[msg.sender] = 1;
    }
    
    function showGovtOrgDetails() public {
        require(govtorgLoginStatus[msg.sender] == 1);
        govorg_Name = govtorgDetails[msg.sender].govtOrgName;
        govorg_IdNum = govtorgDetails[msg.sender].govtOrgIdNum;
        govorg_Location = govtorgDetails[msg.sender].govtOrgLocation;
        govorg_HQ = govtorgDetails[msg.sender].govtOrgHeadQuarters;
        govorg_ContactNum = govtorgDetails[msg.sender].govtOrgContactNum;
    }
    function getGovorgName() public view returns(string memory){
        return govorg_Name;
    }
    function getGovorgIdNum() public view returns(string memory){
        return govorg_IdNum;
    }
    function getGovorgLocation() public view returns(string memory){
        return govorg_Location;
    }
    function getGovorgHq() public view returns(string memory){
        return govorg_HQ;
    }
    function getGovorgContactnum() public view returns(uint){
        return govorg_ContactNum;
    }
    function getGovtOrgsCount() public view returns(uint) {
        return govtorgsCount;
    }
    
    function requestDocsFromGovOrg(address requestUser,uint a,uint b) public {
        require(userRegisterStatus[requestUser]==1);
        docsRequestedDB[requestUser][msg.sender] = DocsRequestedDatabase(a,b);
    }
    function getd1() public view returns(uint){
        return d1;
    }
    function getd2() public view returns(uint){
        return d2;
    }
    
    
    
}