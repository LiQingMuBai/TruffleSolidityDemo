pragma solidity^0.5.0;
contract FaZhen {
    
    struct Evidence {
        uint256  user_id;
        uint8    pre_eid;
        string   name;
        string   cert;
        string   sign_code;
        uint256  size;
        string   status;
        string   location;
    }
    
    mapping(uint256 => Evidence) evidences;
    
    uint256[] public evidencesHashs;
    
    event SaveEvidence(uint256 _eid, uint256 _user_id, uint8 _pre_eid, string _name, string _cert, string _sign_code, uint256 _size, string _status, string _location);
      
    uint256 count;
    
    function getUniqueEvidenceId(uint256 user_id, uint256 count) private  returns (uint256) {
        return uint256(keccak256(abi.encodePacked(msg.sender, user_id, count)));
    }
   
   
    function setEvidence(
        uint256  _user_id, 
        uint8  _pre_eid, 
        string memory _name,  
        string memory _cert,
        string memory   _sign_code,
        uint256  _size,
        string memory   _status,
        string memory   _location) public {
        //check need condition
        require(_user_id > 0,"user id is empty");
        uint256 _eid = getUniqueEvidenceId(_user_id, count);
        count++;
        Evidence storage evidence = evidences[_eid];
        
        evidence.user_id = _user_id;
        evidence.pre_eid = _pre_eid;
        evidence.name = _name;
        evidence.cert = _cert;
        evidence.sign_code = _sign_code;
        evidence.size = _size;
        evidence.status = _status;
        evidence.location = _location;
     
        
        evidencesHashs.push(_eid) -1;
        //fire SaveEvidence event
        emit SaveEvidence(_eid, _user_id, _pre_eid, _name, _cert, _sign_code, _size, _status, _location);
    }
    
    function getEvidencesHashs() view public returns(uint256[] memory) {
        return evidencesHashs;
    }
    
    function getEvidence(uint256 _eid) view public returns (uint256 , uint8 , string memory, string memory, string memory, uint256, string memory) {
        return (evidences[_eid].user_id, evidences[_eid].pre_eid, evidences[_eid].name, evidences[_eid].cert, evidences[_eid].sign_code, evidences[_eid].size, evidences[_eid].location);
    }
    
    function countEvidences() view public returns (uint) {
        return evidencesHashs.length;
    }
      
}