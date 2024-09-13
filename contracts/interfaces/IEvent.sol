// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

interface INFTGatedEvent {
     
     function createEvent(string memory _title, string memory _location, uint256 _closeDate) external;

     function registerForEvent(uint256 _eventId) external;

     function isRegistered (uint256 _eventId, address _user) external view returns(bool);

     function getEventDetails(uint256 _eventId) external view returns (string memory title, string memory location, uint256 closeDate);

     function cancelRegistration(uint256 _eventId) external returns (bool);
}