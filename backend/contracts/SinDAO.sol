// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SinDAO is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction,
    AccessControl
{
    using Counters for Counters.Counter;
    enum MonthlyPaymentStatusEnum {
        GENERATED,
        OPEN,
        PAYED,
        OWNED
    }
    enum SpaceStatusEnum {
        AVAILABLE,
        REFORMING,
        UNAVAILABLE,
        DESCONTINUED
    }
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");
    bytes32 public constant CARETAKER_ROLE = keccak256("CARETAKER_ROLE");
    bytes32 public constant MODERATOR_ROLE = keccak256("MODERATOR_ROLE");

    struct User {
        string name;
        bool active;
        bool canInteract;
        // how to get owned and deleguee apartments?
    }

    struct Sale {
        string description;
        uint256 value;
        string referenceUrl;
    }

    struct MoneyMovement {
        string description;
        uint256 value;
        address payee;
        address receiver;
    }

    struct Reservation {
        uint256 apartment;
        uint256 spaceId;
        uint date;
        uint256 value;
    }

    struct Space {
        string name;
        string description;
        Reservation[] reservations;
        uint256 reservationValue;
        SpaceStatusEnum status;
    }

    struct MonthlyPayment {
        MoneyMovement[] bills;
        MonthlyPaymentStatusEnum status;
        address payee;
    }

    MoneyMovement[] public bills;
    mapping(address => User) public users;
    Counters.Counter private _spaceIdCounter;
    mapping(uint256 => Space) public spaces;
    mapping(uint256 => mapping(uint => MonthlyPayment))
        public apartamentToDateToMonthlyPayments;
    mapping(uint => mapping(uint256 => MonthlyPayment))
        public dateToApartamentToMonthlyPayments;
    address private _stableCoinAddress;
    address private _pollingTokenAddress;

    constructor(IVotes _token)
    Governor("SinDAO")
    GovernorSettings(7200 /* 1 day */, 50400 /* 1 week */, 0)
    GovernorVotes(_token)
    GovernorVotesQuorumFraction(4)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
    

    // The following functions are overrides required by Solidity.

    function votingDelay()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingDelay();
    }

    function votingPeriod()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingPeriod();
    }

    function quorum(
        uint256 blockNumber
    )
        public
        view
        override(IGovernor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(AccessControl, Governor) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}