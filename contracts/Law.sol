pragma solidity^0.5.0;
contract Law {
    
    address private owner;

    uint256 ucount;
    // @notice The Constructor assigns the message sender to be `owner`
    constructor() public {
      owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
     require(msg.sender == owner);
     _;
    }
 
    struct Evidence {
        uint256  ehash;
        address  user;
        string   biz_id;
        uint256  pre_eid;
        string   data;
    }
    
    mapping(uint256 => Evidence) evidences;
    
    uint256[] public evidencesHashs;

    mapping(address => uint8) whitelist;
    
    event SaveEvidence(uint256 _eid, uint256 _ehash, address _user, string biz_id, uint256 _pre_eid, string _data);
    
    event SaveWhiteList(address _address, uint8 status);
    
    function setEvidence(
        uint256  _ehash, 
        uint256  _pre_eid, 
        address  _user,  
        string memory  _biz_id,
        string memory  _data) public {
        //check need condition
        require(whitelist[_user] > 0, "sorry,U have no permission");
        require(_ehash > 0, "evidence hash is empty");
        //generate unique evidence id
        uint256 _eid = uint256(keccak256(abi.encodePacked(msg.sender, _ehash, ucount)));
        ucount++;
        Evidence storage evidence = evidences[_eid];

        evidence.ehash = _ehash;
        evidence.pre_eid = _pre_eid;
        evidence.user = _user;
        evidence.biz_id = _biz_id;
        evidence.data = _data;
     
        
        evidencesHashs.push(_eid) -1;
        //fire SaveEvidence event
        emit SaveEvidence(_eid, _ehash, _user, _biz_id, _pre_eid, _data);
    }
    
    function getEvidencesHashs() view public returns(uint256[] memory) {
        return evidencesHashs;
    }
    
    function getEvidence(uint256 _eid) view public returns (
        uint256 ,
        address,
        string memory,
        uint256,
        string memory) {
        return (evidences[_eid].ehash, evidences[_eid].user, evidences[_eid].biz_id, evidences[_eid].pre_eid, evidences[_eid].data);
    }
    
    function countEvidences() view public returns (uint) {
        return evidencesHashs.length;
    }
      
    function updateWhiteList(address _address, uint8 status) public onlyOwner {
        whitelist[_address] = status;
        emit SaveWhiteList(_address, status);
    }

    function checkWhiteList(address _address) view public returns(uint8){
        return whitelist[_address];
    }
}