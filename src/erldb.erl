-module(erldb).

-export([start/0, stop/0, set/3, get/2, delete/2, init/0]).
-export([get/1, delete/1, set/2]).

start() ->
    %application:start(erldb_app).
    ok = lager:start(),
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(sync),
    ok = application:start(erldb).

stop() ->
    application:stop(erldb_app).

init() ->
    {ok, Pid} = gen_server:start_link(erldb_handler, [], []),
    register(erldb, Pid),
    {ok, Pid}.

get(Key, Pid) ->
    gen_server:call(Pid, {get, Key}).
get(Key) ->
    get(Key, erldb).

delete(Key, Pid) ->
    gen_server:cast(Pid, {delete, Key}).
delete(Key) ->
    delete(Key, erldb).

set(Key, Value, Pid) ->
    gen_server:call(Pid, {set, Key, Value}).
set(Key, Value) ->
    set(Key, Value, erldb).
