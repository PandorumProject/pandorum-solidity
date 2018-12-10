pragma solidity ^0.4.18;

contract UserRegister{
 
    struct user{
        
        address userAddress;
        uint joinBlock;
        uint userState; //1 = Registered // 2 = Blocked  // 3= Banned
        string userHash; //some key information of the KYC will be hashed and saved in the blockchain , thats name + origin location
   
    }
        //User Registry Mappings
        mapping(uint=>user) userList;
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
        
        usercount++;
        userList[usercount].userAddress = _userAddy;
        userList[usercount].userState = 1;
        userList[usercount].userHash= _userHash;
    }
    
}


contract PandorumProtocol{
 
//Idea data structure
    struct ideax{
        address creator;
        string idea;
        string problem;
        string[] pillars;
        uint position;
        uint voteCount;
        address[] voterList;
    }

//Pillar data structure
//saves the reference of each objetive   
    struct pillarx{
        address proposer;
        string pillarName;
        string[] objetives;
        uint pillarID;
    }

//Objetive data structure   
//Saves the ID of  father pillar
    struct objetivex{
        address proposer;
        string objetive;
        uint fatherPillar;
        uint objetiveID;
    }
    
//Task data structure
//saves the ID of father objetive
    struct taskx{
        address assignedTo;
        uint reward;
        string status;
        string task;
        uint fatherObjetive;
        uint taskID;
    }

// Proposal data structure
//Works for Tasks, Pillars, Objetives

    struct proposalx{
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
        mapping(uint => ideax) ideaxs;

        //mapping of pillars ordered by id
        mapping(uint => pillarx) pillarxs;

        //mapping of objetives ordered by id
        mapping(uint => objetivex) objetivexs;

        //mapping of tasks ordered by id
        mapping(uint => taskx) taskxs;

        //mapping of proposals by id
        mapping(uint => proposalx) proposalxs;
       
        mapping(uint => uint) objetivesCount;
        
        mapping(uint=>mapping(uint=>uint)) pillarGraph;
        mapping(uint=>mapping(uint=>mapping(uint=>uint))) taskGraph;

        uint userCount; 
        uint ideaCount;
        uint  pillarCount;
        uint  taskCount;
        uint totalStake;
        uint proposalCount;
        
        bool brainstormEvent;
        
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
        
        brainstormEvent = false;
        
        pillarList[0]="Default";
        pillarList[1]="Programming";
        pillarList[2]="Design";
        pillarList[3]="Meta-Project";
        
    }
    
    //MODIFIERS
    
        modifier onlyEventMaster{
        _;   
    }
        modifier onlyRegistered{
        _;   
    }
        modifier onlyBrainstormEvent{
            require(brainstormEvent = true);
        _;   
    }
        modifier onlyAviableMerit{
        _;   
    }
    
    // EVENT MASTER FUNCTIONS
    function startEvent() public onlyEventMaster{
        brainstormEvent = true;
    }
    
    function callCycle(uint _type) public onlyEventMaster{
        
        if(_type== 1){
           //Calls Pandorum Brainstorm callCycle
           //Checks if there is an idea with 51% or more of total users voted when cycle called.
           //In case of true, smart-contract just assigns the held PDT to the winner idea and rewards are assigned to others.
        }
        
        if(_type==2){
            //Calls a standard Pandorum Time-Tick for 
        }
    }
    
    
    // REGISTERED USERS FUNCTION
    
    function addIdea( string _idea, string _problem ) public onlyRegistered onlyBrainstormEvent {
        ideaxs[ideaCount].idea = _idea;
        ideaxs[ideaCount].problem = _problem;
    }
    
    //Only should be excecutable 
    function voteIdea() public onlyRegistered onlyBrainstormEvent {
        ideaxs[0].voteCount++;
        ideaxs[0].voterList[0] = msg.sender;
    }
    
    //This FX should only be execcutable if caller userDefinitorID
    
    function addPillar(string pillar) public{
        pillarCount++;
        pillarxs[pillarCount].pillarName = pillar;
        pillarxs[pillarCount].proposer = msg.sender;
        pillarxs[pillarCount].pillarID = pillarCount;
        objetivesCount[pillarCount] = 1;
    }
    
    //This FX should only be exectuable by responsible definer by pillar
        function addObjetive(uint pillarID, string objetive) public{
        
        objetivexs[objetivesCount[pillarID]].fatherPillar = pillarID;
        objetivexs[objetivesCount[pillarID]].objetive = objetive;
        objetivexs[objetivesCount[pillarID]].objetiveID = objetivesCount[pillarID];
        pillarGraph[pillarID][objetivesCount[pillarID]] = objetivesCount[pillarID];
        objetivesCount[pillarID]++;
      
    }
    function addTask(uint objetiveID, string taskDefinition) public{
        taskCount++;
        taskxs[taskCount].task = taskDefinition;
        taskxs[taskCount].taskID = taskCount;
        taskxs[taskCount].fatherObjetive = objetiveID;
        taskxs[taskCount].status = "Just defined";
        taskxs[taskCount].reward = 0;
    }
    
    //Only should apply if  pillaris not ddefined
    //Pillars should be handled by ID since using string might result users
    //indexing same duplicated pillars
    //so also should happen only if the ID is not used
    //Proposer might be able to define the main objetives of subject area if accepted
    
    function makePillarProposal(uint _pillarID) public{
      proposalCount++;
      proposalxs[proposalCount].voterCounter = 0;
      proposalxs[proposalCount].proposer = msg.sender;
      proposalxs[proposalCount].proposal = pillarList[_pillarID];
      proposalxs[proposalCount].proposalType = 1;
      
    }
    //this fx should only allow to be executed if the objetive is defined
    //Also if objetive is not done yet, otherwise, there will be a modify proposal
    
    function makeTaskProposal(uint objetiveID, string _proposal) public{
        proposalCount++;
        proposalxs[proposalCount].fatherTaskID = objetiveID;
        proposalxs[proposalCount].proposer = msg.sender;    
        proposalxs[proposalCount].proposal = _proposal;
        proposalxs[proposalCount].voterCounter = 0;
    }
    
    function voteForProposal(uint _proposalID) public{
        proposalxs[_proposalID].votesRecived++;
        proposalxs[_proposalID].voters[proposalxs[_proposalID].votesRecived] = msg.sender;
    }
    
    function getObjetiveID(uint pillarID, uint objetiveID) public view returns(uint){
        return pillarGraph[pillarID][objetiveID];
    }
    
    function getMainIdea() public view returns(string){
        return ideaxs[0].idea;
    }
    
    function getPillarByID(uint ID) public view returns(string){
        return pillarxs[ID].pillarName;
    }
    
    function getPillarCount() public view returns(uint){
        return pillarCount;
    }
    
    function getObjetiveByID(uint pillarID, uint objetiveID) public view returns(string){
        return objetivexs[pillarGraph[pillarID][objetiveID]].objetive;
    }
    
    function getTaskByID(uint taskID) public view returns(string){
        return taskxs[taskID].task;
    }
    
}