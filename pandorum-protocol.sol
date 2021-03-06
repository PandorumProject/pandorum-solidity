pragma solidity ^0.4.18;

contract UserRegister{
 
    struct user{
        
        address userAddress;
        uint joinBlock;
        uint userState; //1 = Registered // 2 = Blocked  // 3= Banned
        string userHash; //some key information of the KYC will be hashed and saved in the blockchain , thats name + origin location
   
    }
        //User Registry Mappings
        mapping(uint=>user)  public userList;
        uint usercount = 0;
        address public creator;
    // ------------------------------------------------------------------------
    // Constructor
          constructor() public {
        creator = msg.sender;
    }

    modifier onlyCreator {
        require(msg.sender == creator);
        _;
    }
      
    //Registers users in the Creative Network
    //Assigns an address to the userID of the user mapping
    //_userHash contains username encrypted;
    
    function registerUser ( address _userAddy, string _userHash) 
    public
    onlyCreator{
        
        userList[usercount].userAddress = _userAddy;
        userList[usercount].userState = 1;
        userList[usercount].userHash= _userHash;
        usercount++;
    }
    
    //HARDCODES A LIST OF USERS IN THE NETWORK, THOSE ARE THE DEFAULT ACCOUNTS OF REMIX IDE JVM ACCOUNT DIRECTORY
    
    function testUserRegister() public
    onlyCreator{
        
        userList[usercount].userAddress = msg.sender;
        userList[usercount].userState = 1;
        userList[usercount].userHash= "admin";
        usercount++;
        
        userList[usercount].userAddress = 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c;
        userList[usercount].userState = 1;
        userList[usercount].userHash= "juanelo";
        usercount++;
        
        userList[usercount].userAddress = 0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db;
        userList[usercount].userState = 1;
        userList[usercount].userHash= "romildo";
        usercount++;
        
        userList[usercount].userAddress = 0x583031d1113ad414f02576bd6afabfb302140225;
        userList[usercount].userState = 1;
        userList[usercount].userHash= "pancrasio";
        usercount++;
        
        userList[usercount].userAddress = 0xdd870fa1b7c4700f2bd7f44238821c26f7392148;
        userList[usercount].userState = 1;
        userList[usercount].userHash= "rafa";
        usercount++;   
        
    }
      
}


contract PandorumProtocol is UserRegister{
 
//Idea data structure
    struct ideaNode{
        address creator;
        string idea;
        string problem;
        string[] pillars;
        uint position;
        uint voteCount;
        uint usersVoted;
        address[] voterList;
    }

//Pillar data structure
//saves the reference of each objetive   
    struct pillarNode{
        address proposer;
        string pillarName;
        string[] objetives;
        uint pillarID;
        uint fatherIdeaID;
    }

//Objetive data structure   
//Saves the ID of  father pillar
    struct objetiveNode{
        address proposer;
        string objetive;
        uint fatherPillar;
        uint objetiveID;
    }
    
//Task data structure
//saves the ID of father objetive
    struct taskNode{
        address assignedTo;
        uint reward;
        string status;
        string task;
        uint fatherObjetive;
        uint taskID;
    }

// Proposal data structure
//Works for Tasks, Pillars, Objetives

    struct proposalNode{
        
        address proposer;
        string proposal;
        uint fatherTaskID;
        uint votesRecived;
        address[] voters;
        uint voterCounter;
        uint proposalType;
        
        //0. Task proposal
        //1. Pillar proposal
        //2. Objetive proposal
        
    }
    
    ///CREATE A MATRIX TO COUNT ASSIGN TO AN IDEA THE WHOLE SET OF PILLARS BY ID 
    ///DO THE SAME, SO EACH PILLAR, OBJETIVE AND TASK ARE LINKED TO EACH FATHER AND CHILD
    ///USE THAT INFORMATION TO REFER TO A "NODE" STATE WHEN ASKED IN THE FUNCTIONS
    ///SUCH AS A REWARD BY TASK, OR REWARD BY VOTING A PILLAR OR TASK OR OBJETIVE
   
        //map of idea data structures ordered  by id;
        mapping(uint => ideaNode) ideaMap;

        //mapping of pillars ordered by id
        mapping(uint => pillarNode) pillarMap;

        //mapping of objetives ordered by id
        mapping(uint => objetiveNode) objectiveMap;

        //mapping of tasks ordered by id
        mapping(uint => taskNode) taskxs;

        //mapping of proposals by id
        mapping(uint => proposalNode) proposalMap;
       
        mapping(uint => uint) objetivesCount;
        
        mapping(uint => uint) brainstormVotedByAddress;
        mapping(uint => uint) brainstormMeritInputByID;
        
        mapping(uint=>mapping(uint=>uint)) pillarGraph;
        mapping(uint=>mapping(uint=>mapping(uint=>uint))) taskGraph;

        uint userCount; 
        uint ideaCount;
        uint  pillarCount;
        uint  taskCount;
        uint totalStake;
        uint proposalCount;
        uint meritInBrainstorm;
        uint public usersVotedBrainstorm;
        
        bool public brainstormEvent;
        bool public winnerIdea;
        
        string[] pillarList;
        
        address eventMaster;
        
    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------

    constructor() public {
        
       // ideaxs[0].idea = mainIdea;
       // ideaxs[0].creator = msg.sender;
       // ideaxs[0].position = 0;
       // ideaxs[0].voteCount = 0;
          
        eventMaster = msg.sender;
        
        userCount = 0;  
        pillarCount = 0;
        taskCount = 0;
        proposalCount = 0;
        totalStake = 1000;
        usersVotedBrainstorm = 0;
        meritInBrainstorm = 0;
        brainstormEvent = false;
        

    }
    
    // ------------------------------------------------------------------------
   //MODIFIERS
  // ------------------------------------------------------------------------
  
        modifier onlyEventMaster{
            require(eventMaster == msg.sender);
        _;   
    }
        modifier validateProposal{
        _;   
    }
        modifier validateMerit(uint _meritAmount){
        _;   
    }    
        modifier onlyRegistered{
        _;   
    }
        modifier winnerProject{
        _;   
    }
        modifier onlyBrainstormEvent{
            require(brainstormEvent == true);
        _;   
    }
        modifier noBrainstormEvent{
            require(brainstormEvent == false);
        _;   
    }
        modifier onlyAviableMerit{
        _;   
    }
    
    // ------------------------------------------------------------------------
    // EVENT MASTER FUNCTIONS
    // ------------------------------------------------------------------------     
    
    function startEvent() public
    onlyEventMaster{
        
         brainstormEvent = true;
     
    }

    function brainstormCycle() public onlyEventMaster{
        
        uint i;
        
        
        for(i=0;i<usersVotedBrainstorm;i++){
           if( ideaMap[ideaCount].voteCount > (meritInBrainstorm / 2)){
                //Reward by Cycle   
                winnerIdea = true;
           }

        }
        
        if (winnerIdea==false){
               usersVotedBrainstorm = usersVotedBrainstorm /2;
               //Reward by Round
        }

    }
    
    function proposalCycle() public onlyEventMaster noBrainstormEvent{
        
        //For each Proposal in a Pillar any with <51% of pillar-consensus
        
    } 
    
    function recieveTokens() public onlyEventMaster{
        
        //Confirm tokens
        //Assign token to Pandorum Brainstorm event 5% to brainstorm event
        //Assign token to future winner 95% of event token to project development
    
        
    }
    
    // ------------------------------------------------------------------------    
    // REGISTERED USERS FUNCTION
    // ------------------------------------------------------------------------    
    
    //ONLY AVIABLE WHEN PANDORUM BRAINSTORM IS OPEN
    
    function addIdea( string _idea, string _problem )
    public
    onlyRegistered
    onlyBrainstormEvent {
        
        ideaMap[ideaCount].idea = _idea;
        ideaMap[ideaCount].problem = _problem;
        ideaMap[ideaCount].voteCount = 0;
        ideaMap[ideaCount].usersVoted = 0;
        ideaCount++;
        
    }
    
    // Only should be excecutable when Pandorum Brainstorm is activated
    
    function voteIdea( uint _ideaID, uint _meritAmount)
    public
    onlyRegistered
    onlyBrainstormEvent
    validateMerit(_meritAmount){
        

        ideaMap[_ideaID].voterList[ideaMap[_ideaID].voteCount] = msg.sender;
        ideaMap[_ideaID].voteCount += _meritAmount;
        meritInBrainstorm += _meritAmount;
        //SAVES THE ACTUAL USER ID INTO A ORDERED LIST OF USERS THAT VOTED -  THIS WILL BE USED TO DISTRIBUTE TOKENS WITH PARETTOS PRINCIPLE
        brainstormVotedByAddress[usersVotedBrainstorm] = getUserIDbyAddress(msg.sender);
        //SAVES THE AMOUNT OF MERIT AS INPUT TO THE ORDERED LIST, THIS WILL BE ADDED BY THE BONUS OR NOT WHEN CYCLE IS CLOSED
        brainstormMeritInputByID[usersVotedBrainstorm]= _meritAmount;
        usersVotedBrainstorm++;
        
    }
    
    // Only applies to Pandorum Brainstorm Event winner projects 
    function makeProposal(uint _type, uint _pillarID, uint  _uintObjetiveID , uint _taskID ) public winnerProject{
        
    }
    
    // Only applies to Pandorum Brainstorm Event winner projects
    function voteProposal(uint _proposalID, uint meritAmount) public onlyRegistered validateProposal winnerProject {
        
    }
    
    //Only for project owner in case of Centralized
    function addPillar(string pillar, uint _ideaID) public{
        
        pillarCount++;
        pillarMap[pillarCount].pillarName = pillar;
        pillarMap[pillarCount].proposer = msg.sender;
        pillarMap[pillarCount].pillarID = pillarCount;
        pillarMap[pillarCount].fatherIdeaID=_ideaID;
        objetivesCount[pillarCount] = 1;
        
    }
    
    //Only for project owner in case of Centralized
    function addObjetive(uint pillarID, string objetive) public{
        
        objectiveMap[objetivesCount[pillarID]].fatherPillar = pillarID;
        objectiveMap[objetivesCount[pillarID]].objetive = objetive;
        objectiveMap[objetivesCount[pillarID]].objetiveID = objetivesCount[pillarID];
        pillarGraph[pillarID][objetivesCount[pillarID]] = objetivesCount[pillarID];
        objetivesCount[pillarID]++;
      
    }
    
    //Only for project owner in case of Centralize    
    function addTask(uint objetiveID, string taskDefinition) public{
        
        taskCount++;
        taskxs[taskCount].task = taskDefinition;
        taskxs[taskCount].taskID = taskCount;
        taskxs[taskCount].fatherObjetive = objetiveID;
        taskxs[taskCount].status = "Just defined";
        taskxs[taskCount].reward = 0;
        
    }
    
    // ------------------------------------------------------------------------    
    // GETTERS
    // ------------------------------------------------------------------------
    
    function getObjetiveID(uint pillarID, uint objetiveID) public view returns(uint){
        return pillarGraph[pillarID][objetiveID];
    }
    
    function getMainByID(uint _ID) public view returns(string){
        return ideaMap[_ID].idea;
    }
    
    function getPillarByID(uint _ID) public view returns(string){
        return pillarMap[_ID].pillarName;
    }
    
    function getPillarCount() public view returns(uint){
        return pillarCount;
    }
    
    function getUserIDbyAddress(address _userAddress) public returns (uint) {
        
    }
    
    function getObjetiveByID(uint pillarID, uint objetiveID) public view returns(string){
        return objectiveMap[pillarGraph[pillarID][objetiveID]].objetive;
    }
    
    function getTaskByID(uint taskID) public view returns(string){
        return taskxs[taskID].task;
    }
    
}