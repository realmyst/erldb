-module(erldb).
-export([start/0, stop/0, set/3, get/2, delete/2, init/0]).

start() ->
    application:start(erldb_app).

stop() ->
    application:stop(erldb_app).

init() ->
    [].

set(List, Key, Value) ->
    Res = orddict:store(Key, Value, List),
    {ok, Res}.

get(List, Key) ->
    Value = orddict:fetch(Key, List),
    {ok, Value}.

delete(List, Key) ->
    Res = orddict:erase(Key, List),
    {ok, Res}.
