// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Script, console} from "forge-std/Script.sol";
import {PoolToken} from "../src/PoolToken.sol";
import {PoolNFT} from "../src/PoolNFT.sol";

contract ContractsScript is Script {
    PoolToken public token;
    PoolNFT public nft;

    function setUp() public {}

    function run() public {
        uint chainId = block.chainid;
        console.log("Deploying to chain:", chainId);

        uint INITIAL_SUPPLY = 1000000 ether;

        string URI = bafkreiejf63jkiglsjmbqlhmduf7li7rebs5ec27vjczm6yvikszvstoyq;

        vm.startBroadcast();

        token = new PoolToken(INITIAL_SUPPLY);
        console.log("Contract Token deployed at:", address(token));

        nft = new PoolNFT();
        console.log("Contrat NFT deployed at:", address(nft));

        vm.stopBroadcast();
    }
}
