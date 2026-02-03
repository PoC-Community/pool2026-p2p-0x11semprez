// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Test} from "forge-std/Test.sol";
import {PoolToken} from "../src/PoolToken.sol";

contract TestPoolToken is Test {
    PoolToken public token;

    address owner = address(this);
    address user = 0x7585149f7a1281280fe44Aff1c6055623B44f395;

    uint INITIAL_SUPPLY = 100000000 ether;

    string URI = bafkreiejf63jkiglsjmbqlhmduf7li7rebs5ec27vjczm6yvikszvstoyq;

    function setUp() public {
        token = new PoolToken(INITIAL_SUPPLY);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
    }

    function testOnlyOwnerCanMint() public {
        vm.prank(user);
        vm.expectRevert();
        token.mint(user, 1000 ether);
    }
}
