pragma solidity >=0.5.0 <0.6.0;

contract ToDo {
    
    struct ToDoItem {
     string ownerName;
     string task;
     uint32 dueDate;
     bool done;
    }
    
    
    ToDoItem[] public toDoItems;
    
    mapping (uint => address) public itemByOwner;
    
    uint private itemCount = 0;
    
    function addToDoItem(string memory _ownerName, string memory _task, uint _amountOfTime) public {
        uint id = toDoItems.push(ToDoItem(_ownerName, _task, uint32(now + _amountOfTime), false)) - 1;
        itemByOwner[id] = msg.sender;
        itemCount++;
    }
    
    modifier onlyOwner(uint _itemId) {
        require(msg.sender == itemByOwner[_itemId], 'Invalid node');
        _;
    }
    
    modifier itemExist(uint _itemId) {
        require(_itemId < itemCount, 'Item does not exist');
        _;
    }
    
    function setDone(uint _itemId) public onlyOwner(_itemId) itemExist(_itemId){
        toDoItems[_itemId].done = true;
    }
    
    function setTask(uint _itemId, string memory _newTask) public onlyOwner(_itemId) itemExist(_itemId) {
        toDoItems[_itemId].task = _newTask;
    }
    
    function setDueDateExtension(uint _itemId, uint _extensionDays) public onlyOwner(_itemId) itemExist(_itemId) {
        toDoItems[_itemId].dueDate = toDoItems[_itemId].dueDate + uint32(_extensionDays);
    }
    
    function getItemsOwnerName(uint _itemId) public view itemExist(_itemId) returns(string memory) {
        return toDoItems[_itemId].ownerName;
    }
    
    function getItemsTask(uint _itemId) public view itemExist(_itemId) returns(string memory) {
        return toDoItems[_itemId].task;
    }
    
    function getItemsDueDate(uint _itemId) public view itemExist(_itemId) returns(uint) {
        return toDoItems[_itemId].dueDate;
    }
    
    function getItemsStatus(uint _itemId) public view itemExist(_itemId) returns(bool) {
        return toDoItems[_itemId].done;
    }
}