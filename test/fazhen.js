const FaZhen = artifacts.require("FaZhen");

contract('FaZhen', (accounts) => {
  it('should statistics be zero', async () => {
    const fazhenInstance = await FaZhen.deployed();
    const stat = await fazhenInstance.countEvidences.call();
    assert.equal(stat.valueOf(), 0, "null data in blockchain,it's wrong");
  });
  
});
