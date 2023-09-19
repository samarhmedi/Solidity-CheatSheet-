// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0; 

contract SimpleStorage {
// declarinf a state variable to store an integer for example 
                                            uint256 public data;

// function to set the store data 
function setData(uint256 _value) public {
                            data = _value;
}
}