--- Creates an array of values by running each element of `array` through `iteratee`
--- The `iterate` is invoked with three arguments: (value, index, array)
---
--- Example:
--- ```
--- local function square(n)
---     return n * n
--- end
---
--- map({ 4, 8 }, square)
--- -- { 16, 64 }
--- ```
---@generic I, O
---@param array I[]? The array to iterate over.
---@param iteratee fun(value: I, index: integer, array: I[]): O The function invoked per iteration.
---@return O[] mapped The new mapped array
local function map(array, iteratee)
	if array == nil then
		return {}
	end

	local length = #array
	local index = 1

	local mapped = {}
	while index <= length do
		mapped[index] = iteratee(array[index], index, array)
		index = index + 1
	end

	return mapped
end

return map