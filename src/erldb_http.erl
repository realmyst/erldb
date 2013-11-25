-module(erldb_http).

-export([start/0, stop/0]).

start() ->
    ok = lager:start(),
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(sync),
    ok = application:start(erldb).

stop() ->
    ok.
