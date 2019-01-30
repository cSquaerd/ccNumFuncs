module ccNumFuncs
	export listDigits, isOdd, isEven, isTriangle, isSquare, isCube, isPandigital, isHappy, pascalTriLine

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

	function isOdd(n::Integer)
		n % 2 == 1
	end

	function isEven(n::Integer)
		n % 2 == 0
	end

	function isTriangle(n::Integer)
		local l = isqrt(2 * n)
		l^2 + l == 2 * n
	end

	function isSquare(n::Integer)
		isqrt(n) == sqrt(n)
	end

	function isCube(n::Integer)
		try
			Int(cbrt(n)) == cbrt(n)
		catch
			false
		end
	end

	function isPandigital(n::Integer)
		local digits = listDigits(n)
		for d = 0:9
			in(d, digits) ? continue : (return false)
		end
		true
	end

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
