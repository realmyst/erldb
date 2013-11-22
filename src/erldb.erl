-module(erldb).
-export([start/0, stop/0, set/3, get/2, delete/2, init/0, db_loop/1]).

start() ->
    application:start(erldb_app).

stop() ->
    application:stop(erldb_app).

init() ->
    spawn_link(erldb, db_loop, [[]]).

set(Key, Value, Db) ->
    Db ! {set, Key, Value},
    ok.

get(Key, Db) ->
    Db ! {get, Key, self()},
    receive
        {ok, Value} ->
            {ok, Value}
    end.

delete(Key, Db) ->
    Db ! {get, Key},
    ok.

db_loop(List) ->
    receive
        {get, Key, Pid} ->
            Value = orddict:fetch(Key, List),
            Pid ! {ok, Value},
            db_loop(List);
        {set, Key, Value} ->
            List2 = orddict:store(Key, Value, List),
            db_loop(List2);
        {delete, Key} ->
            orddict:delete(Key, List),
            db_loop(List)
    end.
