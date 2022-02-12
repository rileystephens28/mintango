const { expect } = require("chai");
const Mintango = artifacts.require("Mintango");

// Start test block
contract("Mintango", (accounts) => {
  beforeEach(async () => {
    // Deploy a new Box contract for each test
    this.erc1155Instance = await Mintango.new({
      from: accounts[0],
    });
  });
});
