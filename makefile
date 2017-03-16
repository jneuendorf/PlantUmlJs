all:
	coffee -c js_uml.coffee
	coffee --bare -c plantuml_preview.coffee
	coffee -c test.coffee

test_node: all
	cat ./underscore.js ./heterarchy.js ./rawdeflate.js ./js_uml.js ./plantuml_preview.js ./test.js | node
