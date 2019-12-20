const Law = artifacts.require("Law");
// const assert = require("chai").assert;
const truffleAssert = require('truffle-assertions');

contract('Law', (accounts) => {
  it('should statistics be zero', async () => {
    const LawInstance = await Law.deployed();
    const stat = await LawInstance.countEvidences.call();
    assert.equal(stat.valueOf(), 0, "null data in blockchain,it's wrong");
  });

  it('should white list size be one', async () => {
    const LawInstance = await Law.deployed();
    const isVIP = await LawInstance.checkWhiteList.call(accounts[0]);

    assert.equal(isVIP.valueOf(), 0, "this account should have no permission");
  });

  it('should account is not in whitelist', async () => {
    const LawInstance = await Law.deployed();
    const isVIP = await LawInstance.checkWhiteList.call(accounts[0]);

    assert.equal(isVIP.valueOf(), 0, "this account should have no permission");
  });

  it('should account is in whitelist', async () => {
      const LawInstance = await Law.deployed();
      // Setup 2 accounts.
      const accountOne = accounts[0];
      const accountTwo = accounts[1];

      const status = 1;
      await LawInstance.updateWhiteList(accountTwo, status, { from: accountOne });

      const isVIP = await LawInstance.checkWhiteList.call(accountTwo);

      assert.equal(isVIP.valueOf(), 1, "this account should have permission");
  });

  it('should Evidence array > zero ', async () => {
      const LawInstance = await Law.deployed();
      // Setup 2 accounts.
      const accountOne = accounts[0];
      const accountTwo = accounts[1];
      const status = 1;
      // Setup update
      await LawInstance.updateWhiteList(accountTwo, status, { from: accountOne });
      const isVIP = await LawInstance.checkWhiteList.call(accountTwo);
      assert.equal(isVIP.valueOf(), 1, "this account should have permission");
      const ehash = 1;
      const _pre_eid = 1;
    
      const _biz_id = "1";
      const _data = "1";

      await LawInstance.setEvidence(ehash, _pre_eid, accountTwo, _biz_id, _data);

      const stat = await LawInstance.countEvidences.call();
      assert.equal(stat.valueOf(), 1, "this smart contract's evidence have one record");
  });


  it('events: should fire SaveWhiteList event properly', async () => {
    const LawInstance = await Law.deployed();
    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];
    const accountThree = accounts[2];
    const status = 1;
    let tx = await LawInstance.updateWhiteList(accountTwo, status, { from: accountOne });
    // fire SaveWhiteList event
    truffleAssert.eventEmitted(tx, 'SaveWhiteList', (ev) => {
        return ev._address === accountTwo && ev.status == 1;
    });
    const isVIP = await LawInstance.checkWhiteList.call(accountTwo);
    assert.equal(isVIP.valueOf(), 1, "this account should have permission");
  });

  it('events: should fire SaveEvidence event properly', async () => {
    const LawInstance = await Law.deployed();
      // Setup 2 accounts.
      const accountOne = accounts[0];
      const accountTwo = accounts[1];
      
      const status = 1;
      // Setup update
      await LawInstance.updateWhiteList(accountTwo, status, { from: accountOne });
      const isVIP = await LawInstance.checkWhiteList.call(accountTwo);
      assert.equal(isVIP.valueOf(), 1, "this account should have permission");
      const ehash = 1;
      const _pre_eid = 1;
    
      const _biz_id = "1";
      const _data = "1";
     // fire setEvidence event
      let tx = await LawInstance.setEvidence(ehash, _pre_eid, accountTwo, _biz_id, _data);

      truffleAssert.eventEmitted(tx, 'SaveEvidence', (ev) => {
        console.log("=====================================================")
        console.log("<<<<<<<<<<<<<<<<<<<<<"+ev._eid+">>>>>>>>>>>>>>>>>>>>>>");
        console.log("=====================================================")
        return ev._ehash == 1 && ev._pre_eid == 1 && ev._user === accountTwo;
      });
      const stat = await LawInstance.countEvidences.call();
      assert.equal(stat.valueOf(), 2, "this smart contract's evidence have two records");
  });
});
