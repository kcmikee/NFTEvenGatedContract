# NFTGatedEvent Smart Contract

## Overview

NFTGatedEvent is a Solidity smart contract that enables the creation and management of events where attendance is gated by NFT ownership. This contract allows event organizers to create events, and participants to register for events if they own an NFT from a specified collection.

## Features

- Event creation by contract owner
- User registration for events
- Registration cancellation
- NFT ownership verification for registration
- Event details retrieval

## Prerequisites

- Node.js (v12.0.0 or later)
- npm (usually comes with Node.js)
- Hardhat

## Setup and Installation

1. Clone the repository:
   ```
   git clone https://github.com/Belloabraham121/NFT-Gated-Event-Management-System.git
   cd NFT-Gated-Event-Management-System
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Install Hardhat (if not already installed):
   ```
   npm install --save-dev hardhat
   ```

4. Install OpenZeppelin Contracts:
   ```
   npm install @openzeppelin/contracts
   ```

5. Configure Hardhat:
   Create a `hardhat.config.js` file in the root directory if it doesn't exist already. Here's a basic configuration:

   ```javascript
   require("@nomicfoundation/hardhat-toolbox");

   module.exports = {
     solidity: "0.8.24",
     networks: {
       hardhat: {},
       // Add other network configurations as needed
     },
   };
   ```

6. Compile the contract:
   ```
   npx hardhat compile
   ```

## Contract Details

### Structs

- `Event`: Stores event details including ID, title, location, close date, and registered attendees.

### Main Functions

1. `createEvent(string memory _title, string memory _location, uint256 _closeDate)`:
   - Creates a new event (only callable by the contract owner).

2. `registerForEvent(uint256 _eventId)`:
   - Allows users to register for an event if they own an NFT.

3. `cancelRegistration(uint256 _eventId)`:
   - Allows users to cancel their registration for an event.

4. `isRegistered(uint256 _eventId, address _user)`:
   - Checks if a user is registered for a specific event.

5. `getEventDetails(uint256 _eventId)`:
   - Retrieves the details of a specific event.

### Events

- `EventCreated`: Emitted when a new event is created.
- `UserRegistered`: Emitted when a user registers for an event.
- `UserRegistrationCancelled`: Emitted when a user cancels their registration.

## Usage

1. Deploy the contract, providing the address of the NFT contract that will be used for gating:
   ```
   npx hardhat run scripts/deploy.js --network <your-network>
   ```

2. The contract owner can create events using `createEvent`.
3. Users who own an NFT from the specified collection can register for events using `registerForEvent`.
4. Users can cancel their registration using `cancelRegistration`.
5. Anyone can check registration status and event details using `isRegistered` and `getEventDetails`.

## Testing

Run the test suite:
```
npx hardhat test
```

## Security Considerations

- The contract inherits from OpenZeppelin's `Ownable`, ensuring only the owner can create events.
- Proper checks are implemented to prevent invalid operations (e.g., registering after the close date).
- NFT ownership is verified before allowing registration.

## License

This project is licensed under the terms specified in the LICENSE file.

---

Note: This README provides an overview of the contract's functionality. Always ensure to thoroughly test and audit smart contracts before deploying them to a live blockchain network.