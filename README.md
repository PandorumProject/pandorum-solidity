![pandorum logo](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/logo-4k.png)
Under construction
## Synopsis

Smart-contracts will allow us to make a total new way of organization and task-making from open-collaborative projects that are rewarded with ERC-20 Token (lets leave the Ether for Gas only). 

We have made a RegisterUser contract Freelancing scrow contract and Token Emit contract which will be used by  Pandorum Protocol contract as a tool.

We believe that with the right UX this will bring a new way of making income from apps on internet, so maybe we can reduce the pain produced by purposely failed economies.

This protocol will allow users to make straight collaborative projects from ideas, no need of extra knowledge, no need of extra action, just think and share.

Join us or start competing, anyways lets make this a better place.

## Pandorum Protocol Meta-Processes

This protocol is meant to have two kind of users, one is the high creativiy theoretical user which will be helpfull to direct the projects. The other will be the Maker, which will have the assigned tasks from each projects.
To really make a good benefit among users, this protocol has been thinked to just use one a project a time, so token emition can really be focused on getting things done, also less dependence on userbase consistency.

![pandorum flow](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/pandorum-flow.png)

For each Idea published in the Pandorum Blockchain, one smart-contract with all the requiered protocol will be made and it will be registered in the main contract of Pandorum Creative Network. 
Eventough an idea could miss the Idea Clash event, its still possible to ask for crowdfunding in order to make the project happen. 

### To Consider 

Altough this is Alpha Version, we believe this could be very usefull under some certain aspect of characteristics which will be mentioned below.

* Pandorum Token is the way of paying users for finishing tasks or making proposals in the theoretical level
* Merit Token is a way of accountability of impact, which are sent only in one direction after it gets burned for Pandorum Tokens.
* Cycles are the unit of time that we will use in the protocol, we can consider them as mid-range "time ticks"
* Pandorum Protocol is meant to work in cycles of constant improvement, if a cycle repeats over time, it will be more possible to stop each round, since the range of possibilities gets reduced.
* This system requires of an Account Manager, which does not have direct permissions over the funds, but has over, starting / calling a cycle in the Network.
* We use a side-chain with no barrier entry fees to do all the voting process and low-cost modifications in the smart-contracts.
* Code only works on Remix IDE Compiler V.0.4.23, will be updated ASAP.

#### User Impact ELO

The Validation or the put of Merit Tokens in activities that end offering value to the community, will be recorded, so we can arrange an ranking of active users, and make mathematical models so users that make more impact, get more rewarded, and users with less experience, makes less impact.
All this in order to mitigate malicious peers making accounts just to pump the vote of a project, and magnifying the impact of users that show good behavior over time.  

#### Malicious User Mitigation

### Pandorum Brainstorm (Idea's Clatch)

Protocol opens the Polls for open-ideas proposals, every participant in RegisterUser contract with user.state = 1 (Registered) will be allowed to publish an idea. Those ideas will be published on the Pandorum Client, and users will vote and select which idea will be developed. This event is supossed to take from one to two weeks.
![pandorum flow](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/pandorum-brainstorm.PNG)

* Users have 5 Merit Votes to distribute every three days. The process of ideas selection will be done over a championiship-like process.

* "n" amount of ideas will be selected, in a pre-phase, then next round (n/2) and so on, untill two ideas clashes, and the network can decide with a 51% of approvation. The scope of "n" will be determined based on user amount.

* Ideas are meant to recieve 5% of the total token distribution assigned over time.

* If a project correctly passes the Brainstorm process, the creative theoretical users will be able to start defining the objetives of each projects via proposals, the protocol is meant to assign tasks to responsible peers by an active userbase consensys.

* For each Idea Vote users will have the possibility to do an impact feedback to the idea, and by other hand, start to defining the main project objetives in case, the idea passes to the next phase, the goal is that projects will be enough defined to start acting after it passes the "Final of Ideas"

* Allowing Crowdfunding could equal that some proyect dont need to be selected by the Poll Cycles
### Pandorum Tasks

When objetives are defined, freelancers or "makers" will be able to make proposals about how to solve each objetive, each task will have a determined amout of reward, based on the reserved amount of tokens held in the smart-contract of a winner idea.


![pandorum task](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/pandorum-task.PNG)

## How to Deploy

### Requeriments

* Solidity Compiler, Remix IDE v. 0.4.23 - (Will be updated to actual compiler ASAP)
* Ether for smart-contract deploy (Ropsten Test-Network works well)
* EVM Interface as MetaMask or MyEtherWallet
* Yet still some imagination

### Contracts in Order

For the system working on his entire design, we have to deploy each contract in order

#### Pandorum Token Contract

The Pandorum Token contract will handle 1000 projects over the existence of this emition, each project will have a predetermined reward that will decrease overtime. The reason for this, is to make the fact that the best moment of taking action is the present moment, making the first projects the best one to get the biggest rewards.

>registerAccountManager(address _accountManager)

Will allow us to register the user which will be responsible of selecting registering the peers in the network.

#### UserRegister Contract

To avoid spam attacks only registered users might be able to post ideas, this could be amazingly scalated if we integrated decentralized identity systems. 

So to start, just deploy the UserRegister contract, and give the constructor the address of the Pandorum Token Contract as Input, this should keep the Account Manager updated.

>registerUser(address _userAddress, string _username)

Will allow Account Manager to add a new account to the network and initialize it data structure with needed variables.

#### Pandorum Protocol Contract

This contract will allow many ideas, but only one will be selected, and will be used as the one that will be developed. In order to correctly start the process, we just need a userbase and start the Pandorum Brainstorm process, users will instantly able to publish and vote for other ideas, untill the winner idea gets selected.

<pandorumBrainstormStart();

Will just allow registered users to

< ideaProposal(string _idea);

< pillarProposal(uint _pillarID);

< objetiveProposal(uint _pillarID, string _objetive);

And to

< voteForIdea(uint _ideaID, uint _meritTransfered)

< voteForObjetive(uint _ideaID, uint _estimatedPreference)



#### Freelance Scrow  Contract

This could be activated after the first Brainstorm, the moment we need to start resolving tasks, such as defining a theoreticall pillar of a project, this scrow contract will be allowed.
An resolutor will be asigned, and he will earn income, for making the right process you should atleast first deploy the Pandorum Protocol contract.

## How to Administrate
 
### User Register

This can only be done by the Account Manager.
Just add the ethereum address and the _username string.
An contract for the user will be made with 5 merit tokens to distribute, 0 EL0, and timestamp will be the actual blockheight.

### Block an user

This can only be done by special requeriment under the Pandorum Client, Trading Issues might end in blocking users from using the protocol. The only motive this should be applied is to mitigate malicious activities.

### Handling Resolutors

Resolutors are elegible to work with issues and take a fee from it. Resolutors can only be added or removed by the Account Manager

### Handling peer-to-peer issues

Whenever a Contra-Peer or Task Maker have an issue, it will be possible to call it on the smart-contract interface, to bring the assigned resolutor to check the proof, this will unlock the encrypted chat from both users on the Pandorum Client. 

### Start a Pandorum Brainstorm

Calling for the first Pandorum Brainstorm is pretty easy, just sign the contract and it will trigger the event.

For next projects it will only be possible under two options, one is if the project has no more tasks or if the projects has less than 10% of tokens to emit.


  
## How to mitigate Gas entry barrier for users

The costs of running this platform in the Ethereum Network could be astronomically high, this is not just tradding kitties, this requieres of users signing contracts at every moment, every time, and it needs to be fast and free.
Is this possible? Answer yes.

Have we implemented yet? First we will do the User Experience test with Ropsten TestNetwork or similar.

Other solution is Loom SDK, as it offers interconctability with Ethereum Mainnet in a way that you can esure funds in a EVM smart-contract, to make mathematical supossitions on the Loom SDK Blockchain, Loom allows us to define a new chain with total new rules and with programming code very similar to Soliidty, thats SolidityX.
 

## Tests

* Emit tokens by merit has been tested with success
* Token Generation Even has been tested with success
* The Protocol itself and Brainstorm will be tested in a Workshop where we will mint first little tokens


## Contributors



## License
			
