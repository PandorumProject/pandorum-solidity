![pandorum logo](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/logo-4k.png)
Under construction
## Synopsis

Smart-contracts will allow us to make a total new ways of organization and task-making for open-collaborative projects that are rewarded with ERC-20 Token (lets leave the Ether for Gas only). 

We have made a RegisterUser contract Freelancing scrow contract and Token Emit contract which will be used by  Pandorum Protocol contract as a tool.

We believe that with the right UX (which we are working on)  will bring a new way of making income from apps on internet. 

The development or investigation of ideas of impact that the community will choose will be possible and also to find the proper peers to resolve it tasks rewarded by Pandorum Tokens, no need of formal institutions, no need of law enforcement.

So maybe finanlly can reduce the pain produced by purposely failed economies, and create a method around the world, a way to make it never happen again, ever.

This protocol will allow users to make straight collaborative projects from ideas, no need of extra knowledge, no need of extra action, just think and share.

## Pandorum Protocol Meta-Processes

This protocol is meant to have two kind of users, one is the high creativiy theoretical user which will be helpfull to direct the projects. The other will be the Maker, which will have the assigned tasks from each projects.
To really make a good benefit among users, this protocol has been thinked to just use one a project a time, so token emition can really be focused on getting things done, also less dependence on userbase consistency.

![pandorum flow](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/pandorum-flow.png)

For each Idea published in the Pandorum Blockchain, one smart-contract with all the requiered protocol will be made and it will be registered in the main contract of Pandorum Creative Network. 
Eventough an idea could miss the Pandorum Brainstorm event, its still possible to ask for crowdfunding in order to make the project happen. 

### To Consider 

Altough this is alpha version only, we believe this could be very usefull under some certain aspect of characteristics which will be mentioned below.


* Cycles are the unit of time that we will use in the protocol, we can consider them as mid-range "time ticks"
* Pandorum Protocol is meant to work in cycles of constant improvement, if a cycle repeats over time, it will hopefully be more probable to success each next round, since the range of possibilities gets reduced.
* This system requires of an Account Manager, which does not have direct permissions over the funds, but has over, starting / calling a cycle in the Network.
* We use a side-chain with no barrier entry fees to do all the voting process and low-cost modifications in the smart-contracts.
* Code only works on Remix IDE Compiler V.0.4.23, will be updated ASAP.
* Merit Token is a way of accountability of impact, which are sent only in one direction before it gets burned for Pandorum Tokens.
* Pandorum Token is the way of paying users for finishing tasks or making proposals in the theoretical level

#### User Impact ELO & Distribution of Influence

The Validation or the put of Merit Tokens in activities that end offering value to the community, will be recorded, so we can arrange an ranking of active users, and make mathematical models so users that make more impact, get more rewarded, and users with less experience, makes less impact.
All this in order to mitigate malicious peers making accounts just to pump the vote of a project, and magnifying the impact of users that show good behavior over time.  

![pandorum flow](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/parettos-1.gif)

The distribution of influence, and earnings will be tuned in order to follow the Paretto's Principle, which we believe is probably one of best working methods to distribute influence over chaotic-creative systems.
How we will make this formula most accurate possible to human behavior is still a mistery. We will make live tests under controlled conditions, in order to get the correct metrics.

#### Malicious User Mitigation

In order to keep the malicious activy in the projects lowest as possible, we have designed that the protocol will allow peers to report this kind of activity at anytime. This will result in case of proven missconduct, in the transfer of a percentaje of legit merit earned by the malicious user, to the user that makes the report.

Making fake reports in order to try farm merit from other users will result in a permanently ban for the username in the network.

### Pandorum Brainstorm 

Protocol opens the Polls for open-ideas proposals, every participant in RegisterUser contract with user.state = 1 (Registered) will be allowed to publish an idea. Those ideas will be published on the Pandorum Client, and users will vote and select which idea will be developed. This event is supossed to take from one to two weeks.
![pandorum flow](https://github.com/PandorumProject/pandorum-solidity/blob/master/images/pandorum-brainstorm.PNG)

* Users have 5 Merit Votes to distribute every three days. The process of ideas selection-reduction will be done over a championiship-like process.

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

* Solidity Compiler, Remix IDE v. 0.4.23 - (Will be updated to actual compiler after first alpha pandorum-token.sol version coomes out)
* Ether for smart-contract deploy (Ropsten Test-Network works well)
* EVM Interface as MetaMask or MyEtherWallet
* Yet still some imagination

### Contracts in Order

To deploy this project you will just need to run the Pandorum Token contract, which in the future, will load the entire protocol in a singe overlayed contract.

This protocol contains four main components which are represented in each sub-contract (Lets say)

* Pandorum Token
* Pandorum Project Structure and Crowdfund
* Pandorum Decentralized Scrow 
* Pandorum User Register

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
			
