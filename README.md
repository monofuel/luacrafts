# Luacrafts

- Repo of lua projects for learning
    - data structures
    - utility libraries
    - KV database (https://gitlab.com/monofuel34089/distributedsystems)
- initial implementations of everything in lua, with tests
    - could re-implement parts in other languages to swap out when available

## Inspiration

![sheep powered computer](./screenshots/2020-03-30_20.22.35.png)

A while back I got to write a KV store for a [Distributed Systems Class](https://bradfieldcs.com/courses/distributed-systems/). We were allowed to pick any language, so I went with Lua so I could get my database running inside of Minecraft with the Open Computers mod. A replicated database would be very useful in the world of Minecraft, as you want syncronized copies of your data in case a creeper blows up your computer.

After this project, I began to notice how common Lua was. Mostly with games, sometimes added by mods. I knew Lua was frequently used interally for games, but some choose to expose it to the player! It also has many professional uses as well, even though I hadn't bumped into them with my personal work.

I don't think I ever looked to Lua as a language to learn, or even to use it to for casual scripting (especially since you need to add libraries for [proper filesystem use](http://keplerproject.github.io/luafilesystem/)). However Lua is very persistent at finding use cases for itself where other scripting languages don't fit! It's interesting to look at a language that is often used specifically because it's easy to integrate in other projects.

### Games that allow Lua coding

- Satisfactory with the [FicsIt Networks mod](https://ficsit.app/mod/8d8gk4imvFanRs)
- Minecraft
    - With the ComputerCraft mod (now [CC-Tweaked](https://github.com/cc-tweaked/CC-Tweaked))
    - with the [OpenComputers](https://github.com/MightyPirates/OpenComputers) mod
- Factorio with the [Moon Logic](https://mods.factorio.com/mod/Moon_Logic) mod
    - Not lua related, but the [fCPU](https://mods.factorio.com/mod/fcpu) mod is super impressive
- Stormworks has built-in Lua support

### Exciting professional uses of Lua

- [LuCI](https://openwrt.org/docs/techref/luci) the UI for OpenWRT uses Lua (and openWRT is pretty awesome)
- [Scripting in a kernel](https://www.netbsd.org/gallery/presentations/mbalmer/fosdem2012/kernel_mode_lua.pdf)
- [Lua with Nginx](https://github.com/openresty/lua-nginx-module#readme)
- [server-side scripting with Redis](https://redis.io/commands/eval)
- [Nmap scripting](https://nmap.org/book/nse.html)
- [and many many more](https://en.wikipedia.org/wiki/List_of_applications_using_Lua)
# Lua References

- cheatsheet https://devhints.io/lua
- https://wiki.osdev.org/Books
- https://github.com/andremm/lua-parser
- https://github.com/lua/lua
- lua regexes are special https://www.lua.org/manual/5.3/manual.html#6.4.1

# Reading list

- https://wiki.osdev.org/Books
- Engineering a Compiler - Keith Cooper & Linda Torczon
- Clean Code - Robert C. Martin
- Extreme Programming Explained - Kent Beck
- https://martinfowler.com/bliki/DomainDrivenDesign.html

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
    - documentation generator
    - text editor
    - curses menu system
    - csv handling
    - http server / client
        - openAPI
- libraries
    - DNS tools?
    - stats library
    - config loading
        - env / config file
    - some sort of event bus system?
    - encryption library (implement a popular encrytion scheme)
    - color library
    - big number library (like big.js)
    - schema / formatting system (used on KV store)
    - mlib
        - serializer
            - some sort of serializer / schema system that can work across libraries
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