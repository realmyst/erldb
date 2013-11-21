-module(echo).
-export([start/0, loop/0, send/1]).


start() ->
    Pid = spawn_link(echo, loop, []),
    register(loop, Pid),
    {ok, Pid}.

loop() ->
    receive
        {request, Pid, Message} ->
            Pid ! {ok, Message},
            loop();
        stop ->
            ok
    end.

send(Message) ->
    loop ! {request, self(), Message},
    receive
        {ok, Message} ->
            Message
    end.
