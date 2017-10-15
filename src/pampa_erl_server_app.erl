-module(pampa_erl_server_app).
-behaviour(application).
-include("../include/config.hrl").

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    State = #{?STATE_TOKEN => <<"">>},
    Dispatch = cowboy_router:compile([
        {'_', [{"/", pampa_api_handler, State}]}
    ]),
    {ok, _} = cowboy:start_clear(
    	my_http_listener,
        [{port, 9000}],
        #{env => #{dispatch => Dispatch}}
    ),
	pampa_erl_server_sup:start_link().

stop(_State) ->
	ok.
