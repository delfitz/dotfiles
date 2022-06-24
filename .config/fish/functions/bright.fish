function bright
    set -l level 70    
    if test (count $argv) -gt 0
        set level $argv
    end
    echo -s 'setting brightness to ' $level '%'
    ddcutil setvcp 10 $level
end
