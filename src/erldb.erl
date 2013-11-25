-module(erldb).

-export([start/0, stop/0, set/3, get/2, delete/2, init/0]).

start() ->
    application:start(erldb_app).

stop() ->
    application:stop(erldb_app).

init() ->
    gen_server:start_link(erldb_handler, [], []).

get(Key, Pid) ->
    gen_server:call(Pid, {get, Key}).

delete(Key, Pid) ->
    gen_server:cast(Pid, {delete, Key}).

set(Key, Value, Pid) ->
    gen_server:call(Pid, {set, Key, Value}).
