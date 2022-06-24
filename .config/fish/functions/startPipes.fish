function startPipes
    
    if not test -p /tmp/weather-pipe
        mkfifo /tmp/weather-pipe
    end
    perfpipe weather --pipe /tmp/weather-pipe &

    if not test -p /tmp/clock-pipe
        mkfifo /tmp/clock-pipe
    end
    perfpipe clock --pipe /tmp/clock-pipe &
    
    if not test -p /tmp/mpstats-pipe
        mkfifo /tmp/mpstats-pipe
    end
    perfpipe mpstats --pipe /tmp/mpstats-pipe &

    if not test -p /tmp/vnstats-pipe
        mkfifo /tmp/vnstats-pipe
    end
    perfpipe vnstats --pipe /tmp/vnstats-pipe &
    
    if not test -p /tmp/cpuprocs-pipe
        mkfifo /tmp/cpuprocs-pipe
    end
    perfpipe cpuprocs --pipe /tmp/cpuprocs-pipe &

end
