const LipToken = artifacts.require("Migrations");

module.exports = function (deployer) {
  deployer.deploy(LipToken, "LipTokens", "LIPS");
};
