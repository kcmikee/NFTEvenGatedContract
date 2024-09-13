// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Event.sol";

contract EventFactory {

    HavensGate[] havensGate;

    function createEventContract(
        address memory _nftContractAddress
    ) external returns {
        newEvent = new HavensGate(_nftContractAddress);
        havensGate.push(newEvent);
        length_ = havensGate.length;
    }

    function getEventClones() external view returns (HavensGate[] memory) {
        return havensGate;
    }
}
