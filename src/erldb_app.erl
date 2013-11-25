-module(erldb_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, _} = erldb:init(),

    Dispatch = cowboy_router:compile(routes()),
    cowboy:start_http(my_http_listener, 100,
        [{port, 8888}],
        [{env, [{dispatch, Dispatch}]}]
    ),

    erldb_sup:start_link().

stop(_State) ->
    ok.

routes() ->
    [{'_', [
        {"/get/:key", get_handler, []},
        {"/set/:key/:value", set_handler, []},
        {"/delete/:key", delete_handler, []}
    ]}].
