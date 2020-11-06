define setup-color-pipe
    shell rm -f ./.gdb-color-pipe
    set logging redirect on
    set logging on ./.gdb-color-pipe
end

define cleanup-color-pipe
    set logging off
    set logging redirect off
    shell rm -f ./.gdb-color-pipe
end

set prompt \001\033[01;3m\002(gdb) \001\033[0m\002

define hook-backtrace
    setup-color-pipe
end

define hookpost-backtrace
    do-generic-colors
    cleanup-color-pipe
end

define hook-up
    setup-color-pipe
end

define hookpost-up
    do-generic-colors
    cleanup-color-pipe
end

define hook-down
    setup-color-pipe
end

define hookpost-down
    do-generic-colors
    cleanup-color-pipe
end

define hook-frame
    setup-color-pipe
end

define hookpost-frame
    do-generic-colors
    cleanup-color-pipe
end

define info hook-threads
    setup-color-pipe
end

define info hookpost-threads
    do-generic-colors
    cleanup-color-pipe
end

define hook-thread
    setup-color-pipe
end

define hookpost-thread
    do-generic-colors
    cleanup-color-pipe
end

set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set print asm-demangle on
set print array off
set print array-indexes on
