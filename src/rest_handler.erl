-module(rest_server_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/hello", rest_handler, []},
            {"/greet", greet_handler, []}     % <-- ajout ici
            ]}
    ]),
    {ok, _} = cowboy:start_clear(http_listener, [{port, 8080}],
                                 #{env => #{dispatch => Dispatch}}),
    {ok, self()}.

stop(_State) ->
    ok.
