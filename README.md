# Luacrafts

- Repo of lua projects for learning
    - data structures
    - utility libraries
    - KV database (https://gitlab.com/monofuel34089/distributedsystems)
- initial implementations of everything in lua, with tests
    - could re-implement parts in other languages to swap out when supported

# Reading

- cheatsheet https://devhints.io/lua
- https://wiki.osdev.org/Books
- https://github.com/andremm/lua-parser
- https://github.com/lua/lua
- lua regexes are special https://www.lua.org/manual/5.3/manual.html#6.4.1

# Project Ideas / TODO List

- projects
    - satisfactory tools
        - constructor calculator
    - satisfactory ficsit network tools?
    - opencomputers
        - TODO (not updated for 1.18)
    - computercraft
        - TODO
    - screeps
        - TODO
- utilities
    - rollup / minify scripts
        - working on some language parsing stuff
        - some way to add/remove debug / stats / profiler code
    - test framework
    - profiler
    - text editor
    - curses menu system
    - http server / client
        - openAPI
- libraries
    - DNS tools?
    - stats library
    - some sort of event bus system?
    - encryption library (implement a popular encrytion scheme)
    - color library
    - big number library (like big.js)
    - schema / formatting system (used on KV store)
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
- PaaS / FaaS
    - KV datastore (redis-like?)
        - queue system (like SQS)
        - pubsub system (like SNS)
    - S3-like object store
        - dynamic require() system backed by object store?
    - lambda / FaaS
    - identity system
    - permissions system
    
    


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