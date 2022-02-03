LUA=lua5.3

.PHONY: test
test:
	$(LUA) test.lua

.PHONY: stormworks-test
stormworks-test:
	cd stormworks && $(LUA) dualClutch_test.lua