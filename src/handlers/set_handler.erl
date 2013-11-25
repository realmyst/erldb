-module(set_handler).

-behaviour(cowboy_http_handler).

-export([init/3, handle/2, terminate/3]).

init(_Type, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {Key, Req2} = cowboy_req:binding(key, Req),
    {Value, Req2} = cowboy_req:binding(value, Req),
    erldb:set(Key, Value),

    {ok, Req2} = cowboy_req:reply(200, [
            {<<"content-type">>, <<"text/plain">>}
        ], <<"ok">>, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
