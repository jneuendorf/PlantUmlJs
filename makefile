all:
	coffee -c js_uml.coffee
	coffee -c test.coffee

test_node: all
	cat ./js_uml.js ./test.js | node
