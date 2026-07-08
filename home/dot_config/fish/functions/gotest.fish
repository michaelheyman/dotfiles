function gotest --description "Run gotestsum with testdox format"
    set cmd "go run gotest.tools/gotestsum@latest --format testdox $argv"
    echo "• $cmd"
    eval $cmd
end
