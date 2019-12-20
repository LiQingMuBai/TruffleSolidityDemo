# smartcontract
<img src="https://truffleframework.com/img/truffle-logo-dark.svg" width="200">

[![npm](https://img.shields.io/npm/v/truffle.svg)](https://www.npmjs.com/package/truffle)
[![npm](https://img.shields.io/npm/dm/truffle.svg)](https://www.npmjs.com/package/truffle)


<p align="center">
  <img width="100%" src="https://cdn.jsdelivr.net/gh/LiQingMuBai/TruffleSolidityDemo/new.gif">
</p>

# 安装truffle
```
$ npm install -g truffle
$ npm install -g chai
$ npm install -g truffle-assertions
```

# 安装ganache
+  [ganache-cli](https://github.com/trufflesuite/ganache-cli): a command-line version of Truffle's blockchain server.
+  [ganache](https://truffleframework.com/ganache/): A GUI for the server that displays your transaction history and chain state.


# 测试

```javascript

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
```
```
$ truffle test
```
