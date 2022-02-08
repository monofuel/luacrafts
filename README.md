# OpenComputers Projects

- tools in lua for open computers
- mainly just for learning experience


# Reading

- cheatsheet https://devhints.io/lua
- https://wiki.osdev.org/Books
- https://github.com/andremm/lua-parser
- https://github.com/lua/lua
- lua regexes are special https://www.lua.org/manual/5.3/manual.html#6.4.1

# TODO

- rollup / minify scripts?
- lua screeps AI?
- more test framework stuff
- profiler?
- color library
- mlib
    - immutables?
    - arraylist / vector
    - hashmap
    - linked list
    - trees
    - graphs
    - string builder
    - stack
    - heap
    - queue
    - ringbuffer

# Issues

- lua requires are relative to the execution directory
    - https://stackoverflow.com/questions/9145432/load-lua-files-by-relative-path
- need to merge this repo with https://gitlab.com/monofuel34089/distributedsystems


## Notes

- operators & metatable names
```
__eq
__lt
__gt
__le
__ge
__ne (TODO verify this one)

__add
__sub
__muv
__div
__mod
__pow

__unm (unary minus)

__len (length) #array
__index (table, key) t[key] t.key
__newindex (table, key, value) t[key] = value

__concat (left, right) "hello " .. "world"

__call (func, ...)
```

- globals 
```
dofile(filename) / loadfile(filename)

assert(x) assert(x, "message")
type(var) --  "nil" | "number" | "string" | "boolean" | "table" | "function" | "thread" | "userdata"

-- does not invoke meta methods __index and __newindex
rawset(t, index, value)
rawget(t, index)

_G global context

setfenv() -- TODO figure this one out

pairs(t) list of {key, value}
ipairs(t) list of {index, value}
tonumber(value, base)
```