LUA=lua

.PHONY: test
test:
	$(LUA) test.lua

.PHONY: stormworks-test
stormworks-test:
	cd stormworks && $(LUA) dualClutch_test.lua