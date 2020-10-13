#!/usr/bin/env julia

function main(outlen:: Integer)
	chars = Vector{Char}(undef, outlen)
	for i in 1:outlen
		chars[i] = rand(Char)
	end
	print(String(chars))
end

main(parse(Int, ARGS[1]))
