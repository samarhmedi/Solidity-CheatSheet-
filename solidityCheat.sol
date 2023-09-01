// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



// CONTRACT DECLARATION + VARIABLES
contract MyVariables {
    // state variables
    string public myString = "My string";
    bool public boolean1 = true;
    uint public myUint = 1;
    int public myInt = 1;
    address public myAddress = 0x52bc44d5378309EE2abF1539BF71dE1b7d7bE3b5;
} 

// FUNCTIONS
contract MyFunction {
    // state variable ( accessible outside of this function )
    string name = "Example 1";
    
    // write function
    function setName(string memory _name) public {
        // local variable ( only accessible inside this function ) 
        name =  _name ;
    }

    // read function
    function getName() public view returns (string memory) {
        return name ;
    }

    function resetName() public {
        name = "Example 1" ;
    } 
}

// VISIBILITY 
contract MyVisibility {
// no visibility 
    string name1 = "Name 1";
// only visible in the current contract
    string private name2 = "Name 2";
// only visible in the current contract but can be inherited
    string internal name3 = "Name_3";
// visible externally and internally
    string public name4 = "Name 4";
// only visible externally (only for functions)
    // external visibility specifier is not valid for local variables.

    /* the external visibility is typically used for functions 
    that are intended to be called from outside the contract. 
    It is not applicable to variables.*/
}


// MODIFIERS
    /* When a function uses a modifier, the code in the modifier is executed before 
    the code in the function. If the modifier's code execution doesn't encounter a 
    revert statement, the control is passed to the modified function, 
    otherwise, the transaction is reverted. */

contract MyModifier {
    address public owner;

    //  the onlyOwner modifier is defined to restrict access to certain 
    // functions only to the contract's owner it checks if the caller of the function is 
    // the same as the contract's owner address and reverts the transaction if the condition is not met
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this");
        _; // This underscore indicates where the modified function's code will be inserted
    }

    constructor() {
        owner = msg.sender;
    }

    // modifier used in the function
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}

contract ViewPure {
    string public name = "Example 5";
    uint public balance;
    //  the function will not modify the contract's state but can read the state (can read "name")
    function getName() public view returns (string memory) {
        return name;
    }
    // will not modify or access the contract's state
    function add(uint a, uint b) public pure returns (uint) {
    return a + b;
    }
    //  a function can receive Ether (ETH) as part of the transaction.
    function pay() public payable {
        balance = msg.value;
    }
}

// CONSTRUCTORS 
    /*  special function that gets executed only once when a contract is deployed to 
    the blockchain. It is used to initialize the contract's state variables 
    and perform any setup that might be required before the contract becomes operational */

contract MyContructor {
    string public name;
    // same as any fuction and it can be a modifier too 
    constructor(string memory _name) {
        name = _name;
    }
}

// GLOBAL OPERATORS 
    /*  predefined variables that are accessible from any part of your smart contract without 
    needing to declare them explicitly */

contract MyGlobalVariables {
    // Contains the address of the sender of the transaction
    address public sender = msg.sender;

    // Represents the amount of Ether (in Wei) sent along with the transaction
    uint256 public sentValue = msg.value;

    // Holds the current block number in the blockchain
    uint256 public currentBlockNumber = block.number;

    // Provides the Unix timestamp of the current block's creation time
    uint256 public blockTimestamp = block.timestamp;

    // Represents the difficulty level of the current block
    uint256 public blockDifficulty = block.difficulty;

    // Returns the amount of gas remaining in the current execution context
    uint256 public remainingGas = gasleft();

    // Contains the address of the originator of the transaction
    address public txOrigin = tx.origin;

    // Provides the address of the current contract
    address public contractAddress = address(this);

    // Provides a payable address of the current contract
    address payable public payableContractAddress = payable(address(this));

    // Example of using abi.encodePacked for hashing data
    bytes32 public hashedData = keccak256(abi.encodePacked("Hello, Solidity!"));

    // Using bytes32 for creating unique identifiers or hashing data
    bytes32 public uniqueId = keccak256(abi.encodePacked(msg.sender, block.timestamp));
}


// ARRAYS
// collection of variables of the same type just like any oop 

contract MyArray {
    uint256[] public dynamicArray; // Dynamic array
    uint256[5] public fixedArray;  // Fixed-size array

    // Function to add an element to the dynamic array
    function addToDynamicArray(uint256 newValue) public {
        dynamicArray.push(newValue);
    }

    // Function to get the length of the dynamic array
    function getDynamicArrayLength() public view returns (uint256) {
        return dynamicArray.length;
    }

    // Function to access an element from the fixed-size array
    function getFixedArrayElement(uint256 index) public view returns (uint256) {
        return fixedArray[index];
    }

    // Function to demonstrate array iteration
    function sumDynamicArray() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < dynamicArray.length; i++) {
            sum += dynamicArray[i];
        }
        return sum;
    }

    // Function to demonstrate passing arrays to functions
    function doubleArrayValues(uint256[] memory values) public pure returns (uint256[] memory) {
        for (uint256 i = 0; i < values.length; i++) {
            values[i] *= 2;
        }
        return values;
    }
}


// MAPPINGS 
// very similar to dictionaries in python 
// key value pairs 
contract MyMappings {
    // Declare a mapping that associates addresses with integers
    mapping(address => uint256) public balances;

    // Function to set the balance for a specific address
    function setBalance(address account, uint256 amount) public {
        balances[account] = amount;
    }

    // Function to get the balance for a specific address
    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }

    // Function to demonstrate checking for key existence in mapping
    function isAccountExists(address account) public view returns (bool) {
        // Check if the balance is not the default value (0)
        return balances[account] != 0;
    }

    // Function to demonstrate deleting a key-value pair from mapping
    function deleteAccount(address account) public {
        // Set the balance to 0 to "delete" the key-value pair
        balances[account] = 0;
    }

    // Function to demonstrate using structs with mappings
    struct Item {
        uint256 itemId;
        string itemName;
    }

    // Mapping that associates item IDs with Item structs
    mapping(uint256 => Item) public items;

    // Function to add an item to the mapping
    function addItem(uint256 itemId, string memory itemName) public {
        items[itemId] = Item(itemId, itemName);
    }
}

// STRUCT
// used to define custom data types 

contract MyStruct {
    // Define a struct named 'Person' with two members: 'name' and 'age' VEEERY similar to java 
    struct Person {
        string name;
        uint256 age;
    }

    // Declare an instance of the 'Person' struct 
    Person public alice = Person("Alice", 25);

    // Function to update the age of the 'alice' instance
    function updatePersonAge(uint256 newAge) public {
        alice.age = newAge;
    }

    // Array of 'Person' structs
    Person[] public people;

    // Function to add a new person to the 'people' array
    function addPerson(string memory name, uint256 age) public {
        // Creating a new 'Person' struct instance and adding it to the array
        people.push(Person(name, age));
    }

    // Mapping that associates addresses with 'Person' structs
    mapping(address => Person) public addressToPerson;

    // Function to set a 'Person' struct for a specific address
    function setPersonForAddress(string memory name, uint256 age) public {
        addressToPerson[msg.sender] = Person(name, age);
    }
}

// EVENTS
// used to notify external applications of the occurrence of a specific event within a smart contract
contract MyEvents {
    // Declare an event named 'LogNumberUpdated'
    event LogNumberUpdated(address indexed updater, uint256 newValue);

    uint256 public currentNumber;

    // Function to update the current number and log the event
    function updateNumber(uint256 newValue) public {
        // Update the current number
        currentNumber = newValue;

        // Log the 'LogNumberUpdated' event
        emit LogNumberUpdated(msg.sender, newValue);
    }
}


// ETHER FUNCTION 
// used to send and receive Ether (ETH) from a smart contract


contract MyEtherHandling {
    // Fallback function to receive Ether
    receive() external payable {
        // Log the received amount
        emit Received(msg.sender, msg.value);
    }

    // Event to log received Ether
    event Received(address indexed sender, uint256 amount);

    // Function to send Ether to another address using transfer
    function sendEtherUsingTransfer(address payable recipient) public payable {
        require(msg.value > 0, "Must send some Ether");

        // Use transfer to send Ether and handle reverts
        recipient.transfer(msg.value);

        // Log the Ether sent
        emit Sent(msg.sender, recipient, msg.value);
    }

    // Event to log Ether sent
    event Sent(address indexed sender, address indexed recipient, uint256 amount);

    // Function to send Ether to another address using call.value
    function sendEtherUsingCall(address payable recipient) public payable {
        require(msg.value > 0, "Must send some Ether");

        // Use call.value to send Ether and get a success flag
        (bool success, ) = recipient.call{ value: msg.value }("");

        // Check if the call was successful
        if (success) {
            emit Sent(msg.sender, recipient, msg.value);
        }
    }

    // Function to get the contract's Ether balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Function to self-destruct the contract and send Ether to a specified address
    function selfDestruct(address payable beneficiary) public {
        selfdestruct(beneficiary);
    }
    // Function to transfer ether 
    function transferEther(address payable recipient) public payable {
        recipient.transfer(msg.value);
    }
}

// INHERITANCE 
// used to reuse the code from an existing contract and extend its functionality

// Base contract with a virtual function
contract BaseContract {
    uint256 public baseValue;

    // Virtual function to set the base value
    function setBaseValue(uint256 newValue) public virtual {
        baseValue = newValue;
    }
}

// Derived contract inheriting from BaseContract
contract DerivedContract is BaseContract {
    uint256 public derivedValue;

    // Function to set the derived value
    function setDerivedValue(uint256 newValue) public {
        derivedValue = newValue;
    }

    // Override the base function
    function setBaseValue(uint256 newValue) public override {
        // Call the base function using 'super'
        super.setBaseValue(newValue + 100);
    }
}

// Example usage
contract InheritanceExample {
    BaseContract public baseContract;
    DerivedContract public derivedContract;

    constructor() {
        baseContract = new BaseContract();
        derivedContract = new DerivedContract();
    }

    function useContracts() public {
        baseContract.setBaseValue(10);
        derivedContract.setDerivedValue(20);
        derivedContract.setBaseValue(30);
    }
}


// CALLING OTHER CONTRACTS
// used to call functions from other contracts

// Import the ABI of the SecretVault contract
import "./SecretVaultABI.sol";  // Replace with the actual ABI

contract MyOtherContracts {
    // Declare the interface for the SecretVault contract
    SecretVault public secretVault;

    constructor(address secretVaultAddress) {
        // Instantiate the SecretVault contract
        secretVault = SecretVault(secretVaultAddress);
    }

    // Function to retrieve the secret from the SecretVault contract
    function getSecret() public view returns (string memory) {
        return secretVault.getSecret();
    }
}


// INTERFACES 
// used to define the functions and events of a contract without implementing them
//  Interfaces provide a standardized way for contracts to communicate with each other, and they are particularly useful when you want 
// to interact with other contracts that may not yet exist or have a complex implementation.

// Interface declaration
interface SecretVault {
    function getSecret() external view returns (string memory);
}

// Contract implementing the interface
contract MyContract {
    SecretVault public secretVault;

    constructor(address secretVaultAddress) {
        secretVault = SecretVault(secretVaultAddress);
    }

    function getSecretFromVault() public view returns (string memory) {
        return secretVault.getSecret();
    }
}

interface IERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
)
    external
    returns (bool success);
}
contract MyContract {
    function deposit (address _tokenAddress, uint amount) public {
        IERC20 (_tokenAddress).transferFrom (msg.sender, address(this), _amount);
    }
}
