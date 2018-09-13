#!/bin/bash

start_test() {
	echo "##############################"
	echo "# Starting test: $* #"
	echo "##############################"
}

pass() {
	echo "PASS: $*"
}

fail() {
	echo "FAIL: $*"
}

fail() {
	echo "SKIP: $*"
}
