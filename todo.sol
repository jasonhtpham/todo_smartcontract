pragma solidity >=0.5.0 <0.6.0;

contract ToDo {
    
    struct ToDoItem {
     string owner;
     string task;
     uint32 dueDate;
    }
    
    ToDoItem[] public toDoItems;
    
    mapping (uint => address) public itemByOwner;
    mapping (address => uint) itemCountByOwner;
    
    function addToDoItem(string memory _ownerName, string memory _task, uint _amountOfTime) public {
        uint id = toDoItems.push(ToDoItem(_ownerName, _task, uint32(now + _amountOfTime))) - 1;
        itemByOwner[id] = msg.sender;
        itemCountByOwner[msg.sender]++;
    }
    
    function getItemsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](itemCountByOwner[_owner]);
        uint counter = 0;
        for (uint i = 0; i < toDoItems.length; i++) {
            if (itemByOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}