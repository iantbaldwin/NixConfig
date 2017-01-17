function valgrind_d
	docker run --rm -v (pwd)/:/work/ iantbaldwin/gcc-val valgrind $argv
end
