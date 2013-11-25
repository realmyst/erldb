-module(erldb_test).
-include_lib("eunit/include/eunit.hrl").

start_stop_test_() ->
    {setup,
        fun start/0,
        fun stop/1, [
            fun write_success/0,
            fun read_success/0,
            fun delete_success/0
        ]
    }.

start() ->
    erldb:init().

stop(_) ->
    erldb:stop().

write_success() ->
    {ok, Db} = erldb:init(),
    ?assertEqual(ok, erldb:set(key, value, Db)).

read_success() ->
    {ok, Db} = erldb:init(),
    erldb:set(key, value, Db),
    ?assertEqual({ok, value}, erldb:get(key, Db)).

delete_success() ->
    {ok, Db} = erldb:init(),
    erldb:set(key, value, Db),
    ?assertEqual(ok, erldb:delete(key, Db)).
