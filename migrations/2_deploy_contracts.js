const Law = artifacts.require("Law");

module.exports = function(deployer) {
  deployer.deploy(Law);
};
