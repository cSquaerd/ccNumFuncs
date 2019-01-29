module ccNumFuncs
	export pascalTriLine

	function pascalTriLine(n::Integer)
		n == 0 ?
			(return [Int64(1)]) : 
			n > 0 ? 
				true : 
				throw(ArgumentError("`n` must be positive."))
		local prevLine = pascalTriLine(n - 1)
		local line = [Int64(1)]
		for i = 1:n - 1
			push!(line, Int64(prevLine[i]) + Int64(prevLine[i + 1]))
		end
		push!(line, 1)
		line
	end
end
