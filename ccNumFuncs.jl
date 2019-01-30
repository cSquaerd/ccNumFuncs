"""
# ccNumFuncs
## A Numeric Functions module written in Julia
### Description
Module with various miscellaneous functions for classifications of whole numbers
### Functions
* `listDigits`: returns a list of the digits in a number `n` in descending order of magnitude
* `isOdd`: returns `true` if an integer `n` is odd
* `isEven`: returns `true` if an integer `n` is even
* `isTriangle`: returns `true` if an integer `n` is a triangle number
* `isSquare`: returns `true` if an integer `n` is a square number
* `isCube`: returns `true` if an integer `n` is a cube number
* `isPandigital`: returns `true` if an integer `n` is a strict pandigital number
* `isHappy`: returns `true` if an integer is a happy number
* `pascalTriLine`: returns a list of numbers from line `n` of Pascal's Triangle
"""
module ccNumFuncs
	export listDigits, isOdd, isEven, isTriangle, isSquare, isCube, isPandigital, isHappy, pascalTriLine
	"Returns a list of the base-10 digits on a number `n` from most significant to least significant."
	function listDigits(n::Integer)
		n == 0 ?
			(return [0]) :
			n < 0 ?
				throw(ArgumentError("`n` must be positive.")) :
				true
		local digits = []
		m = 0
		while n >= 10 ^ m
			m += 1
		end
		local k = n
		while m > 0
			push!(digits, div(k, 10 ^ (m - 1)) % 10)
			m -= 1
		end
		digits
	end
	"Returns `true` if `n` is odd."
	function isOdd(n::Integer)
		n % 2 == 1
	end
	"Returns `true` if `n` is even."
	function isEven(n::Integer)
		n % 2 == 0
	end
	"Returns `true` if `n` is of the form \$\\frac{k(k + 1)}{2}\$ for some \$k \\in \\mathbb{N}\$."
	function isTriangle(n::Integer)
		local l = isqrt(2 * n)
		l^2 + l == 2 * n
	end
	"Returns `true` if `n` is of the form \$k^2\$ for some \$k \\in \\mathbb{N}\$."
	function isSquare(n::Integer)
		isqrt(n) == sqrt(n)
	end
	"Returns `true` if `n` is of the form \$k^3\$ for some \$k \\in \\mathbb{N}\$."
	function isCube(n::Integer)
		try
			Int(cbrt(n)) == cbrt(n)
		catch
			false
		end
	end
	"Returns `true` if `n` written in base-10 has all base-10 digits in it."
	function isPandigital(n::Integer)
		local digits = listDigits(n)
		for d = 0:9
			in(d, digits) ? continue : (return false)
		end
		true
	end
	"Returns `true` if `n` is happy, which means repeatedly summing the squares of the digits eventually results in \$1\$."
	function isHappy(n::Integer)
		n == 1 ? (return true) : true
		local unhappyNums = Array{Int64}(undef, 0)
		local m = n
		while m != 1
			push!(unhappyNums, m)
			m = mapreduce(x -> x^2, +, listDigits(m))
			in(m, unhappyNums) ? (return false) : continue
		end
		true
	end
	"Recursively generates the `n`th line of Pascal's Triangle, which contain the Binomial Coefficients of an `n`-degree polynomial."
	function pascalTriLine(n::Integer)
		n == 0 ?
			(return [big(1)]) : 
			n > 0 ? 
				true : 
				throw(ArgumentError("`n` must be positive."))
		local prevLine = pascalTriLine(n - 1)
		local line = [big(1)]
		for i = 1:n - 1
			push!(line, prevLine[i] + prevLine[i + 1])
		end
		push!(line, 1)
		line
	end
end
