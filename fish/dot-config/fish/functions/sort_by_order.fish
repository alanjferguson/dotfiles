#!/usr/bin/env bash
# Usage: ./sort_by_order.sh <file_a> <file_b>

function sort_by_order
    set a $argv[1]
    set b $argv[2]

    cat $b | while read -l line
        grep -Fx "$line" $a
    end
end
