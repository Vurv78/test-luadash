local map = require("src.lua.collection.map")

describe("array mapping", function()
	describe("default arguments", function()
		it("should work without an array passed", function()
			local fn = lest.fn()
			map(nil, fn)
			expect(fn).never.toHaveBeenCalled()
		end)
	end)

	describe("invalid cases", function()
		it("should fail on sparse arrays", function()
			local array = { 1, 2, [4] = 4 }

			expect(function()
				map(array, function(n)
					return n * 2
				end)
			end).toThrow("attempt to perform arithmetic on local 'n'")
		end)

		it("should not work with string keys", function()
			local array = { foo = 2, bar = 3 }

			local result = map(array, function(n)
				return n * 2
			end)

			expect(result).toEqual({})
		end)
	end)

	describe("normal cases", function()
		it("should work with an array of numbers", function()
			local array = { 1, 2, 3 }

			local result = map(array, function(n)
				return n * 2
			end)

			expect(result).toEqual({ 2, 4, 6 })
		end)

		it("should be called in order", function()
			local array = { 10, "string", 30, true, 50, 60 }

			local fn = lest.fn()
			map(array, fn)

			expect(fn).toHaveBeenNthCalledWith(1, 10, 1, array)
			expect(fn).toHaveBeenNthCalledWith(2, "string", 2, array)
			expect(fn).toHaveBeenNthCalledWith(3, 30, 3, array)
			expect(fn).toHaveBeenNthCalledWith(4, true, 4, array)
			expect(fn).toHaveBeenNthCalledWith(5, 50, 5, array)
			expect(fn).toHaveBeenNthCalledWith(6, 60, 6, array)
		end)
	end)
end)