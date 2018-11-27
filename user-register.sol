pragma solidity ^0.4.18;


contract UserRegister{
 
    
    // Data structure for user Definition
    
    struct userX{
        
        string username;
        address userAddress;
        uint joinBlock;
        uint activeMerits; //Merits used to vote
        uint recievedMerits;//Total Count of Merit
        uint totalTasks;
        uint state; //0. Registered 1. Blocked 2. Banned
        uint openIssues;
            
    }
    
 
    
        //User Registry Mappings
        
        mapping(uint => userX) userlist;
        mapping(string=>uint) userIDList;
        mapping(string => bool) isRegistered;
        uint usercount;
        address accountManager;
        
    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------

    constructor ( ) public {
        
        usercount = 0;
        accountManager = msg.sender;
        
    }
    
          modifier onlyAccountManager 
        {
            require(msg.sender == accountManager);
            _;
        }
        
          modifier uniqueUser (string _username)
        {
            require(isRegistered[_username] == false);
            _;
        }
        
          modifier onlyRegisteredUser (string _username)
        {
            require(isRegistered[_username] == true);
            _;
        }
        
    
    function registerUser (string _username, address _userAddy) 
    public
    onlyAccountManager
    uniqueUser(_username){
        
        usercount++;
        
        userIDList[_username] = usercount;
        
        userlist[usercount].username = _username;
        userlist[usercount].userAddress = _userAddy;
        userlist[usercount].joinBlock = now;
        userlist[usercount].activeMerits = 5;
        userlist[usercount].recievedMerits = 0;
        userlist[usercount].totalTasks = 0;
        userlist[usercount].state = 0;
        userlist[usercount].openIssues = 0;
        isRegistered[_username] = true;
        
    }
    
    function reportUser (string _username)
    public
    onlyRegisteredUser(_username){
        userlist[userIDList[_username]].openIssues++;
    }

    
}