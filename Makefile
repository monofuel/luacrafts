

.PHONY: test
test:
	lua5.3 test.lua

.PHONY: stormworks-test
stormworks-test:
	cd stormworks && lua5.3 dualClutch_test.lua