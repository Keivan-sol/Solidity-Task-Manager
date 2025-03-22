// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {
    struct Task {
        string description;
        bool isCompleted;
    }
    
    mapping(address => Task[]) public userTasks;

    event TaskAdded(address indexed owner, string description);
    event TaskUpdated(address indexed owner, uint index, string newDescription);
    event TaskRemoved(address indexed owner, uint index);

    function addTask(string memory _description) public {
        userTasks[msg.sender].push(Task(_description, false));
        emit TaskAdded(msg.sender, _description);
    }

    function updateTask(uint _index, string memory _newDescription) public {
        require(_index < userTasks[msg.sender].length, "Task doesn't exist");
        require(!userTasks[msg.sender][_index].isCompleted, "Task is completed");
        userTasks[msg.sender][_index].description = _newDescription;
        emit TaskUpdated(msg.sender, _index, _newDescription);
    }

    function removeTask(uint _index) public {
        require(_index < userTasks[msg.sender].length, "Task doesn't exist");
        require(!userTasks[msg.sender][_index].isCompleted, "Task is completed");
        delete userTasks[msg.sender][_index];
        emit TaskRemoved(msg.sender, _index);
    }

    function taskComplete(uint _index) public {
        require(_index < userTasks[msg.sender].length, "Task doesn't exist");
        require(!userTasks[msg.sender][_index].isCompleted, "Task is completed");
        userTasks[msg.sender][_index].isCompleted = true;
    }

    function getAllTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }
}