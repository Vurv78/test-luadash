local function getAbsoluteStart(pos, len)
	if pos > 0 then
		return pos
	elseif pos == 0 then
		return 1
	elseif pos < -len then
		return 1
	else
		return len + pos + 1
	end
end

local function getAbsoluteEnd(pos, len)
	if pos > len then
		return len
	elseif pos >= 0 then
		return pos - 1
	elseif pos < -len then
		return 0
	else
		return len + pos
	end
end

--- Creates a slice of given `array` from `start`, up to, but not including, `finish`.  
---
--- Example:
---
--- ```
--- local array = {1, 2, 3, 4}
--- slice(array, 3)
--- -- { 3, 4 }
--- ```
---@generic T
---@param array T[]? Array to slice.
---@param start number? Start position. A negative index will be treated as an offset from the end. Defaults to 1.
---@param finish number? End position. A negative index will be treated as an offset from the end. Defaults to #array.
---@return T[] slice The slice of `array`
local function slice(array, start, finish)
	if array == nil then
		return {}
	end

	local len = #array
	start = start and getAbsoluteStart(start, len) or 1
	finish = finish and getAbsoluteEnd(finish, len) or len

	local slice = {}
	if start <= finish then
		for i = start, finish do
			slice[i - start + 1] = array[i]
		end
	end

	return slice
end

return slice