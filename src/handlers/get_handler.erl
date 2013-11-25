-module(get_handler).

-behaviour(cowboy_http_handler).

-export([init/3, handle/2, terminate/3]).

init(_Type, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {Key, Req2} = cowboy_req:binding(key, Req),
    {ok, Value} = erldb:get(Key),

    {ok, Req3} = cowboy_req:reply(200, [
            {<<"content-type">>, <<"text/plain">>}
        ], Value, Req2),
    {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
    ok.
