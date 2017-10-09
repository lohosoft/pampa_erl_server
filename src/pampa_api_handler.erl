-module(pampa_api_handler).
-behavior(cowboy_handler).

-export([init/2]).

init(Req, State) ->
	io:print("~p",Req),
	{ok, Req, State}.
