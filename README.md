# BetterTables
This is a module that has a function that can return an object with more functions for a table!

(This is just for fun, it may have already been done before)

Learn more https://github.com/AngryPlaayer/BetterTables/wiki

Here's some functions, more info on the wiki page
### VV

BetterTablesModule:new(table) -> returns BetterTable object with the table

BetterTablesModule:getBetterTables() -> returns every single BetterTable object in the server

BetterTablesModule.enum -> all the enums for the module
	events:
		dataAdded
		dataRemoved
	merging:
		overwrite
	sorting:
		leastGreatest
		greatestLeast
		random
		equalTo
(More info on enums in the wiki)

BetterTable.is -> returns enum.misc.is, useful for identifying BetterTable objects
		
BetterTable.on(index,callback) -> callback will run every time the specified event happens, carrying respective paramaters
		
BetterTable.get(index) -> returns the data in that index of the table
		
BetterTable.call(index,arguments...) -> if the index in the table is a function, it will call the function. Paramaters are put after the index
		
BetterTable.toArray() -> returns the given table
		
BetterTable.foreach(function) -> runs the function for each item in the table
		
BetterTable.concat() -> returns the concaterated table
		
BetterTable.sort() -> sorts the table with some extra preset functions
		
BetterTable.getRandom() -> returns a random value and index from the table
		
BetterTable.cloneArray() -> makes a cloned table of the array
		
BetterTable.remove(function) -> if the function returns true, it will remove the current index
BetterTable.remove(function(data,index) <Example
	return a > 5 or index > 4
end) -> if any of the data in the table are equal to 5, the index will be removed
		
BetterTable.find(function) -> if the function returns true, return the data that satisfies the function
		
BetterTable.findall(function) -> same thing as "BetterTable.find()", but returns all the satisfying data in a table, or nil if nothing is found
		
BetterTable.add(value,index) -> the value is added to the index of the table
		
BetterTable.help() -> prints and returns a list of functions to use
		
BetterTable.print() -> prints all of the values in the table
