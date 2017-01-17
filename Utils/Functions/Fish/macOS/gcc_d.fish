function gcc_d
	docker run --rm -v (pwd)/:/work/ iantbaldwin/gcc-val gcc $argv
end
