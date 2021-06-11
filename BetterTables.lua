local t = {}

t.__index = t

t.enum = {
	events = {
		dataRemoved = '97915508228716758441251773444413171553208',
		dataAdded = '564279816125816306101261992129077794804441'
	},
	merging = {
		overwrite = '95696227653688411837345784762355354743515'
	},
	misc = {
		is = '43586493750607002606251146281363752455031'
	},
	sorting = {
		leastGreatest = '528747569578512166594501789991115764896114',
		greatestLeast = '71139845723643918005016677775908111946256',
		random = '326174320650882777450567695147541615166277',
		equalTo = '19816916279323321448770787108482398831387'
	}
}

local BetterTables = {}

function t:getBetterTables()
	return t:new(BetterTables)
end

function t:new(a)
	
	assert(typeof(a) == 'table', "Argument passed is not a table!")
	
	local m = setmetatable({},self)
	m.__index = m
	
	local enum = t.enum
	
	local array = a
	
	local Call = {}
	
	local function call(index,data)
		Call.index = index
		Call.data = data
		wait()wait()
		Call = {}
	end
	
	m.find = function(callback)
		for i,v in pairs(array) do
			local s,e = pcall(function()
				if not callback(v,i) then
					error()
				end
			end)
			if s then return v,i end
		end
		return nil
	end
	
	m.findAll = function(callback)
		local toReturn = {}
		for i,v in pairs(array) do
			pcall(function()
				if callback(v) then
					toReturn[i] = v
				end
			end)
		end
		return toReturn
	end
	
	m.add = function(value,index)
		if index then
			array[index] = value
		else
			table.insert(array,#array+1,value)
		end
		call(enum.events.dataAdded, {value,index})
		return array
	end
	
	m.remove = function(callback)
		local toSend = {}
		for i,v in pairs(array) do
			if callback(v,i) then
				if typeof(i) == "number" then
					table.insert(toSend,1,array[i])
					table.remove(array,i)
				else
					toSend[i] = array[i]
					array[i] = nil
				end
			end
		end
		call(enum.events.dataRemoved,{toSend,array})
		return array
	end
	
	function m.print()
		local toPrint = "\n"
		for i,v in pairs(array) do
			toPrint = toPrint..tostring(i).." = "..tostring(v).."\n"
		end
		print(toPrint)
	end
	
	m.concat = function()
		return table.concat(array)
	end
	
	m.sort = function(index)
		if index == enum.sorting.leastGreatest then
			table.sort(array,function(a,b)
				return a < b
			end)
		elseif index == enum.sorting.greatestLeast then
			table.sort(array,function(a,b)
				return a > b
			end)
		elseif index == enum.sorting.random then
			table.sort(array,function(a,b)
				return math.random(1,2) == 1
			end)
		elseif index == enum.sorting.equalTo then
			table.sort(array,function(a,b)
				return a == b
			end)
		elseif typeof(index) == "function" then
			table.sort(array,index)
		else
			error("Argument 1 must be a function or a sorting enum value!")
		end
		return array
	end
	
	m.getRandom = function()
		local rand = math.random(1,#array)
		
		for i,v in ipairs(array) do
			if i == rand then
				return v,i
			end
		end
	end
	
	m.foreach = function(callback)
		pcall(function()
			table.foreach(array,callback)
		end)
	end
	
	m.toArray = function()
		return array
	end
	
	m.call = function(index,...)
		assert(typeof(array[index]) == "function", "The index you called is not a function!")
		array[index](...)
	end
	
	m.get = function(index)
		return array[index]
	end
	
	m.cloneArray = function()
		local toReturn = {}
		for i,v in pairs(array) do
			toReturn[i] = v
		end
		return toReturn
	end
	
	m.on = function(index,callback)
		if index == enum.events.dataAdded then
			coroutine.resume(coroutine.create(function()
				local row = 0
				while true do
					repeat wait() until Call.index == index
					row += 1
					if row > 1 then
						row = 0
						continue
					end
					local s,e = pcall(function()
						callback(Call.data[1],Call.data[2],array)
					end)
					if not s then
						warn(e)
					end
				end
			end))
		elseif index == enum.events.dataRemoved then
			coroutine.resume(coroutine.create(function()
				local row = 0
				while true do
					repeat wait() until Call.index == index
					row += 1
					if row > 1 then
						row = 0
						continue
					end
					local s,e = pcall(function()
						callback(Call.data[1],Call.data[2])
					end)
					if not s then
						warn(e)
					end
				end
			end))
		
		end
	end
	
	m.is = enum.misc.is
	
	m.merge = function(BetterTable,index)
		assert(BetterTable.is == enum.misc.is, "Argument 1 needs to be a BetterTable object!")
		
		local toArray = BetterTable.toArray()
		local clonedArray = m.cloneArray()
		
		for i,v in pairs(BetterTable.toArray()) do
			if clonedArray[i] ~= nil and index == enum.merging.overwrite then
				clonedArray[i] = v
			elseif array[i] == nil then
				clonedArray[i] = v
			end
		end
		
		return t:new(clonedArray)
	end 
	
	m.help = function()
		local Text = [[
		Hi! Thanks for using BetterTables. Here's a list of functions:
		
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
		
		BetterTable:print() -> prints all of the values in the table
		]]
		print(Text)
		return Text
	end
	
	return m
end

return t
