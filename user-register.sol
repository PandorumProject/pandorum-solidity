pragma solidity ^0.4.18;


contract RegisterUser{
 

    struct userX{
        
        string username;
        address userAddy;
        uint joinDate;
        uint activeMerits;
        uint recievedMerits;
        uint totalTasks;
        uint state; //0. Registered 1. Blocked 2. Banned
            
    }
        //mapping reserved for ideas saved by address
        
        mapping(uint => userX) userlist;
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
        
    
    function registerUser (string _username, address _userAddy) 
    public
    onlyAccountManager
    uniqueUser(_username){
        
        usercount++;
        userlist[usercount].username = _username;
        userlist[usercount].userAddy = _userAddy;
        userlist[usercount].joinDate = now;
        userlist[usercount].activeMerits = 5;
        userlist[usercount].recievedMerits = 0;
        userlist[usercount].totalTasks = 0;
        userlist[usercount].state = 0;
        isRegistered[_username] = true;
        
    }

    
}