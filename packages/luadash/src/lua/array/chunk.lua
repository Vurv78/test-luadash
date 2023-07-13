local slice = require("src.lua.array.slice")

--- Creates an array of elements split into arrays of the length `size`.
--- If `array` can't be split evenly, final chunk will contain the remaining elements.
---
--- Example:
--- ```
--- chunk({1, 2, 3, 4}, 2)
--- -- { { 1, 2 }, { 3, 4 } }
---
--- chunk({'a', 'b', 'c', 'd'}, 3)
--- -- {{ 'a', 'b', 'c' }, { 'd' }}
--- ```
---@generic T
---@param array T[]? Array to chunk.
---@param size integer? Length of each chunk. Defaults to 1.
---@return T[][] chunks New array of chunks
local function chunk(array, size)
	size = size or 1

	if array == nil or size < 1 then
		return {}
	end

	local length = #array

	local chunks = {}
	local index, chunk_index = 1, 1

	while index <= length do
		chunks[chunk_index] = slice(array, index, index + size)

		index = index + size
		chunk_index = chunk_index + 1
	end

	return chunks
end

return chunk