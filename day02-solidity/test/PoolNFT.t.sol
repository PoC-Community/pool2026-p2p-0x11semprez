//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Test} from "forge-std/Test.sol";
import {PoolNFT} from "../src/PoolNFT.sol";

contract TestPoolNFT is Test {
    PoolNFT public nft;

    address owner = address(this);
    address user = 0xcc7319039E4BB42D9A4134da9A6Cf4e88cE1853e;

    string URI = bafkreiejf63jkiglsjmbqlhmduf7li7rebs5ec27vjczm6yvikszvstoyq;

    function setUp() public {
        nft = new PoolNFT(URI);
    }

    function onlyOwnerCanMint() public {
        vm.prank(user);
        vm.expectRevert();
        nft.mint(0xC344E8Cb33379128aeaa22400b9B68a2AE4a8e34);
    }
}
