-module(ring).
-export([start/1, loop/2, start_ring/1, stop_ring/1, message_ring/1]).

-export([start_process/1, start_process/2]).

start(ProcessCount) ->
    spawn_link(ring, start_process, [ProcessCount]).

start_process(ProcessCount) ->
    Pid = spawn_link(ring, start_process, [ProcessCount-1, self()]),
    loop(Pid, start).

start_process(0, MasterPid) ->
    loop(MasterPid, start);
start_process(ProcessCount, MasterPid) ->
    Pid = spawn_link(ring, start_process, [ProcessCount-1,  MasterPid]),
    loop(Pid, start).

loop(ChildPid, start) ->
    receive
        {message, Count} ->
             ChildPid ! {message, Count+1},
             loop(ChildPid, start);
        {start} ->
             loop(ChildPid, start);
        {stop} ->
             ChildPid ! {stop},
             loop(ChildPid, stop)
end;

loop(ChildPid, stop) ->
    receive
        {message, Count} ->
            erlang:display(Count),
            loop(ChildPid, stop);
        {start} ->
             ChildPid ! {start},
             loop(ChildPid, start);
        {stop} ->
             loop(ChildPid, stop)
end.

start_ring(Ring) ->
    Ring ! {start}.

stop_ring(Ring) ->
    Ring ! {stop}.

message_ring(Ring) ->
    Ring ! {message, 0}.

