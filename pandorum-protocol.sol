pragma solidity ^0.4.18;


contract Map{
 
 //////////////////////////////////////////////////////
 // STRUCTS///////////////////////////////////////////
 //////////////////////////////////////////////////
 /////////////////IDEA STRUCT///////////////////////
    struct ideax{
        address creator;
        string idea;
        string[] pillars;
        uint position;
        uint voteCount;
        address[] voterList;
    }
 /////////////PILLAR STRUCT////////////////////     
    struct pillarx{
        address proposer;
        string pillarName;
        string[] objetives;
        uint pillarID;
    }
////////OBJETIVE STRUCT//////////////    
    struct objetivex{
        address proposer;
        string objetive;
        uint fatherPillar;
        uint objetiveID;
    }
    
///////TASK STRUCT/////////

    struct taskx{
        address assignedTo;
        uint reward;
        string status;
        string task;
        uint fatherObjetive;
        uint taskID;
    }
///Proposal struct

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
    
        //mapping reserved for ideas saved by address

        mapping(uint => ideax) ideaxs;
        mapping(uint => pillarx) pillarxs;
        mapping(uint => objetivex) objetivexs;
        mapping(uint => taskx) taskxs;
        mapping(uint => proposalx) proposalxs;
        
        mapping(uint => uint) objetivesCount;
        mapping(uint=>mapping(uint=>uint)) pillarGraph;
        mapping(uint=>mapping(uint=>mapping(uint=>uint))) taskGraph;

        uint userDefinitorID;    
        uint  pillarCount;
        uint  taskCount;
        uint totalStake;
        uint proposalCount;
        
        string[] pillarList;
        
    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------

    constructor(string mainIdea) public {
        
        ideaxs[0].idea = mainIdea;
        ideaxs[0].creator = msg.sender;
        ideaxs[0].position = 0;
        ideaxs[0].voteCount = 0;
        pillarCount = 0;
        taskCount = 0;
        proposalCount = 0;
        totalStake = 1000;
        
        pillarList[0]="Default";
        pillarList[1]="Programming";
        pillarList[2]="Design";
        pillarList[3]="Misc";
        
    }
    //Only should be excecutable 
    function voteIdea() public{
        ideaxs[0].voteCount++;
        ideaxs[0].voterList[0] = msg.sender;
    }
    
    function selectPillarDefinitor (uint userID ) public{
        userDefinitorID = userID;
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
