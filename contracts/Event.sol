// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HavensGate is Ownable {
    uint256 eventCount;
    IERC721 public nftContract;

    struct Event {
        uint256 eventId;
        string title;
        string location;
        uint256 closeDate;
        mapping(address => bool) registeredAttendees;
    }

    constructor(address _nftContractAddress) Ownable(msg.sender) {
        nftContract = IERC721(_nftContractAddress);
    }

    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => bool)) hasRegistered;

    event EventCreated(
        uint256 indexed eventId,
        string indexed title,
        string indexed location,
        uint256 closeDate
    );
    event UserRegistered(uint256 indexed eventId, address indexed user);
    event UserRegistrationCancelled(
        uint256 indexed eventId,
        address indexed user
    );

    function createEvent(
        string memory _title,
        string memory _location,
        uint256 _closeDate
    ) external onlyOwner {
        require(msg.sender != address(0), "address zero detected");
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_location).length > 0, "Location cannot be empty");
        require(_closeDate > 0, "Input close date");

        uint256 _eventId = eventCount + 1;
        Event storage et = events[_eventId];

        et.eventId = _eventId;
        et.title = _title;
        et.location = _location;
        et.closeDate = _closeDate * (block.timestamp + 60);
        eventCount += 1;
    }

    function registerForEvent(uint256 _eventId) external {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        Event storage event_ = events[_eventId];
        require(
            block.timestamp < event_.closeDate,
            "Event registration closed"
        );
        require(!event_.registeredAttendees[msg.sender], "Already registered");
        require(
            nftContract.balanceOf(msg.sender) > 0,
            "Must own an NFT to register"
        );

        event_.registeredAttendees[msg.sender] = true;

        emit UserRegistered(_eventId, msg.sender);
    }

    function isRegistered(
        uint256 _eventId,
        address _user
    ) external view returns (bool) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        return events[_eventId].registeredAttendees[_user];
    }

    function getEventDetails(
        uint256 _eventId
    )
        external
        view
        returns (string memory title, string memory location, uint256 closeDate)
    {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        Event storage et = events[_eventId];
        return (et.title, et.location, et.closeDate);
    }

    function cancelRegistration(uint256 _eventId) external returns (bool) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        Event storage event_ = events[_eventId];
        require(
            event_.registeredAttendees[msg.sender],
            "Not registered for this event"
        );
        require(
            block.timestamp < event_.closeDate,
            "Event registration closed"
        );

        event_.registeredAttendees[msg.sender] = false;

        emit UserRegistrationCancelled(_eventId, msg.sender);
        return true;
    }
}
