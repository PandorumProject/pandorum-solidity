pragma solidity ^0.4.18;
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
// Safe maths
// ----------------------------------------------------------------------------

contract SafeMath {
    function safeAdd(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}
// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
// ----------------------------------------------------------------------------
// Contract function to receive approval and execute function in one call
//
// Borrowed from MiniMeToken
// ----------------------------------------------------------------------------
contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}
// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

contract MeritEmition {
    
    mapping(uint=>address) userBase;
    uint public totalUsers;
    
    mapping(address=>uint) meritBase;
    uint public totalMerit;
    
    function signForMerit() public{
        if(meritBase[msg.sender]==0){
            meritBase[msg.sender] = 1;
            userBase[totalUsers] = msg.sender;
            totalMerit++;
            totalUsers++;
        }
        
    } 
    
    function getTotalMerit()public view returns(uint){
        return totalMerit;
    }
}
// ----------------------------------------------------------------------------
// ERC20 Token, with the addition of symbol, name and decimals and assisted
// token transfers
// ----------------------------------------------------------------------------
contract ToToken is ERC20Interface, Owned, SafeMath, MeritEmition {
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    uint public _emitSupply;
    uint public totalSold;
    uint public startDate;
    uint public bonusEnds;
    uint public endDate;
    
    uint toEmit;
    uint public tokenPerMerit; // 
    bool emitionSystem;
    
    mapping(address => uint) balances;
    mapping(address=>uint) meritRegister;
    mapping(address => mapping(address => uint)) allowed;


    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    constructor() public {
        symbol = "Pandorum Token";
        name = "PDT";
        decimals = 18;
        bonusEnds = now + 1 weeks;
        endDate = now + 7 weeks;
        _totalSupply = 7e26;
        _emitSupply = 1e26;
        emitionSystem = false;
        toEmit = 1e24;
        totalUsers = 0;
        totalMerit = 0;
        
        //Reserved tokens for Pandorum Founders
        balances[address(0x092EaB8751CCB99b1C0b87ff816fa6dBd6513Ea5)]=42e24;
        emit Transfer(address(0), 0x092EaB8751CCB99b1C0b87ff816fa6dBd6513Ea5, 42e24);
        
        //Reserved tokens for Merit System
       // balances[address(0)]= 198e24;
       
        totalSold = balances[address(0x092EaB8751CCB99b1C0b87ff816fa6dBd6513Ea5)] ;

    }


    // ------------------------------------------------------------------------
    // Total supply
    // ------------------------------------------------------------------------
    function totalSupply() public constant returns (uint) {
        return _totalSupply - _emitSupply;
    }


    // ------------------------------------------------------------------------
    // Get the token balance for account `tokenOwner`
    // ------------------------------------------------------------------------
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }
    function tokensSold() public constant returns(uint){
        return totalSold/1E18;
    }
    function tokensLeft() public constant returns(uint){
        return (_totalSupply-totalSold)/1E18;
    }

    // ------------------------------------------------------------------------
    // Transfer the balance from token owner's account to `to` account
    // - Owner's account must have sufficient balance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Token owner can approve for `spender` to transferFrom(...) `tokens`
    // from the token owner's account
    //
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
    // recommends that there are no checks for the approval double-spend attack
    // as this should be implemented in user interfaces
    // ------------------------------------------------------------------------
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Transfer `tokens` from the `from` account to the `to` account
    //
    // The calling account must already have sufficient tokens approve(...)-d
    // for spending from the `from` account and
    // - From account must have sufficient balance to transfer
    // - Spender must have sufficient allowance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Returns the amount of tokens approved by the owner that can be
    // transferred to the spender's account
    // ------------------------------------------------------------------------
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }


    // ------------------------------------------------------------------------
    // Token owner can approve for `spender` to transferFrom(...) `tokens`
    // from the token owner's account. The `spender` contract function
    // `receiveApproval(...)` is then executed
    // ------------------------------------------------------------------------
    
    function approveAndCall(address spender, uint tokens, bytes data) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
        return true;
    }
    
    //Starts the emition
    //100,000,000 tokens to emit, emition every three days
    
    function startEmition() public {
        //CALCULATE TOTAL AMOUNT OF MERIT don
        //TRANSFERING TO EACH USER IN MAPPING OF MERIT
        //REPEAT IN TIME FOR NEXT EMITION WITH LESS TOKENS
        emitionSystem = true;
    }
    
    function emitionCycle() public {
        
        tokenPerMerit = safeDiv(toEmit,getTotalMerit());
        uint i;
        
        for(i=0;i<totalUsers;i++){
            balances[userBase[i]] = safeAdd(balances[userBase[i]], safeMul(tokenPerMerit, meritBase[msg.sender]));
            emit Transfer(this, userBase[i] , safeMul(tokenPerMerit, meritBase[msg.sender]));
        }
        
        _emitSupply = _emitSupply - toEmit;
        toEmit = toEmit - calcEmitDifferential();
    }
    
    function calcEmitDifferential() public pure returns(uint){
        return 1e21;
    }
    
    // ------------------------------------------------------------------------
    // 5,000 FWD Tokens per 1 ETH
    // ------------------------------------------------------------------------
    function () public payable {
        require(now >= startDate && now <= endDate && totalSold < (totalSupply()-msg.value*12000000) && msg.value<5e18 );
        uint tokens;
        if (now <= bonusEnds) {
            tokens = msg.value * 12000000;
        } else {
            tokens = msg.value * 12000000;
        }
        balances[msg.sender] = safeAdd(balances[msg.sender], tokens);
        emit Transfer(this, msg.sender, tokens);
        totalSold = totalSold+tokens;
        owner.transfer(msg.value);
    }



    // ------------------------------------------------------------------------
    // Owner can transfer out any accidentally sent ERC20 tokens
    // ------------------------------------------------------------------------
    function transferAnyERC20Token(address tokenAddress, uint tokens) public onlyOwner returns (bool success) {
        return ERC20Interface(tokenAddress).transfer(owner, tokens);
    }
}