pragma solidity ^0.5.2;

contract CryptoTree {
    uint256 private nextId;
    uint256 public interestFrequency;

    struct Loan {
        uint256 amount;
        // type // DAI, USDC, etc
        address owner;
        uint256 openedTimestamp;
        uint256 nextMaturityTimestamp;
        // payee? self or charity

        uint256 lendingPlatformId // ie, id on Compound
        uint256 interestPaidOut
    }

    mapping (uint256 => Loan) idToLoan;

    constructor () public {
        nextId = 1;
        interestFrequency = 1 hours; // change to 30 days for v1
    }

    function createLoan (uint256 _amount) public payable returns (uint256 id_) {
        Loan memory loan = Loan(_amount, _owner, now, now + interestFrequency);
        idToLoan[nextId] = loan;
        nextId++;

        return nextId - 1;
    }

    function getLoan (uint256 _id) view public returns (
        uint256 amount_, address owner_, uint256 openedTimestamp_,
        uint256 nextMaturityTimestamp_, uint256 ) {
        Loan memory loan = idToLoan[_id];

        return (loan.amount, loan.owner, loan.openedTimestamp,
                loan.nextMaturityTimestamp)
    }

}
