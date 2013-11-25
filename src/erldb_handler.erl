-module(erldb_handler).

-behaviour(gen_server).

-export([init/1, handle_call/3, code_change/3, handle_cast/2, handle_info/2, terminate/2]).

init([]) ->
    {ok, []}.

handle_call({get, Key}, _, State) ->
    Value = orddict:fetch(Key, State),
    {reply, {ok, Value}, State};
handle_call({set, Key, Value}, _, State) ->
    State2 = orddict:store(Key, Value, State),
    {reply, ok, State2}.

handle_cast({delete, Key}, State) ->
    State2 = orddict:erase(Key, State),
    {noreply, State2}.

code_change(_, _, _) ->
    ok.

handle_info(_, _) ->
    ok.

terminate(_, _) ->
    ok.
