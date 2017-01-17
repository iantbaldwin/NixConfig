function execute_d
	docker run --rm -v (pwd):/work/ iantbaldwin/gcc-val:latest $argv
end
