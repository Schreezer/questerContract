// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
contract Quest {
    string public name = "Quester";
    address public store;
    address public owner;
    string public symbol = "QUE";
    uint256 public totalSupply = 10000000;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        owner=msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }
    
    function set_owner(address stor) public returns (bool success){
        require(msg.sender==owner, "You can't do it, so Fuck off!!");
        owner=stor;
        return true;
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function stored(address from, uint256 value) public returns (bool success){
        require(msg.sender==owner, "You cant change another users balance");
        require(balanceOf[from]>= value, "not enough balance");

        balanceOf[from]-=value;
        balanceOf[msg.sender]+=value;
        return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        require(balanceOf[_from] >= _value, "Not enough balance");
        require(allowance[_from][msg.sender] >= _value, "Not enough allowance");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract Querry {
    uint256 public master = 69;
    Quest public token;
    struct mapi{
        address answerer;
        string answer;
    }
    struct Card{
        uint256 index;
        address querrier;
        string question;
        // now we need to store the answers as a mapping of address to string
        // mapping (address=>string) answers;
        mapi [] answers;
        uint256 numberAnswers;
        uint256 timestamp;
        uint256 bounty;
    }
    Card[] cards;
    mapi[] ans_map;
    // this is the map which will store the cards as a mapping from the index number of that card
    // mapping (uint256=>Card) public cards;
    // this is the variable which will store the number of cards, to help retrieve all the cards 
    uint256 numberQuestions;
    // this is the mapping which will store the balance of the querrier
    mapping(address => uint256) public storedBalanceOf;
    mapping (address=>uint256) public bounty;
    mapping (address=>Card) public card;
    constructor(Quest _token) {
        token = _token;
    }
    function checker(uint256 val) public view returns( bool success){
        require(token.balanceOf(msg.sender)>= val, "Not enough Balance");
        return true;
    }
    // function quest(uint256 _value, string memory _question) public {
    //     require(token.balanceOf(msg.sender)>= _value, "Not enough Balance");
    //     require(token.stored(msg.sender,_value)," Stored function of the ERC20 contract didtn proceed");
    //     // require(token.transferFrom(msg.sender, address(this), _value), "Transfer failed");
        

    //     storedBalanceOf[msg.sender] += _value;
    //     cards.push(Card( msg.sender , _question, block.timestamp, _value));
    // }

    function quest(uint256 _value, string memory _question) public {
        require(token.balanceOf(msg.sender)>= _value, "Not enough Balance");
        require(token.stored(msg.sender,_value)," Stored function of the ERC20 contract didtn proceed");
        // require(token.transferFrom(msg.sender, address(this), _value), "Transfer failed");
        
        storedBalanceOf[msg.sender] += _value;
        // cards[numberQuestions] = Card(msg.sender, _question, 0, block.timestamp, _value);
        // cards.push(Card(numberQuestions ,msg.sender, _question,0, block.timestamp, _value, 0));
        mapi[] memory _empty_ans;
        cards.push(Card(numberQuestions ,msg.sender, _question,_empty_ans ,0, block.timestamp, _value));
        numberQuestions++;
    }

    function transferStored(address _to, uint256 _value) public {
        require(storedBalanceOf[msg.sender] >= _value, "Not enough stored balance");
        storedBalanceOf[msg.sender] -= _value;
        require(token.transfer(_to, _value), "Transfer failed");
    }
    function getAllCards() public view returns (Card[] memory) {
        // this function will return all cards
        return cards;
    }
    function Answer(uint256 cardIndex, string memory answer) public returns (bool success){
        // this function is to be called by the person who wants to answer the question
        cards[cardIndex].answers.push(mapi(msg.sender, answer)) ;
        cards[cardIndex].numberAnswers++;
        return true;
}

    function releaseBounty(uint256 index, address winner) public returns(bool success){
        // this function will be called by the person who created the card, i.e querrier to release funds to the person whose answer he or she liked, after the release the bounty will be set to 0
        require(msg.sender==cards[index].querrier, "You are not the querrier");
        require(cards[index].bounty>0, "No bounty to release");
        require(token.transfer(winner, cards[index].bounty), "Transfer failed");

    }
}