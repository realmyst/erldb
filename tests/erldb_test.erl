-module(erldb_test).
-include_lib("eunit/include/eunit.hrl").

start_stop_test_() ->
    {setup,
        fun start/0,
        fun stop/1, [
            fun write_success/0,
            fun read_success/0,
            fun double_write/0,
            fun delete_success/0
        ]
    }.

start() ->
    erldb:init().

stop(_) ->
    erldb:stop().

write_success() ->
    State = erldb:init(),
    ?assertEqual({ok, [{key, value}]}, erldb:set(State, key, value)).

read_success() ->
    {_, State} = erldb:set([], key, value),
    ?assertEqual({ok, value}, erldb:get(State, key)).

double_write() ->
    {_, State} = erldb:set([], key, value),
    ?assertEqual({ok, [{key, new_value}]}, erldb:set(State, key, new_value)),
    ?assertEqual({ok, [{key, value}, {new_key, value}]}, erldb:set(State, new_key, value)).

delete_success() ->
    {_, State} = erldb:set([], key, value),
    ?assertEqual({ok, []}, erldb:delete(State, key)).
