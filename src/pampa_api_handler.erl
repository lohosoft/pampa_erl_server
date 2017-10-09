-module(pampa_api_handler).
-behavior(cowboy_handler).

-export([init/2]).

init(Req, State) ->
	% io:print("~p",Req),
	Method = cowboy_req:method(Req),
	handle(Method,Req,State).

% for pass wechat token identification
% handle(<<"GET">>,Req,State) ->
% 	Qs1 = cowboy_req:parse_qs(Req),
% 	{_,Echo} = lists:nth(2,Qs1),
% 	Req1 = cowboy_req:reply(
% 			200,
% 			#{<<"content-type">> => <<"text/plain">>},
% 			Echo,
% 			Req
% 			),
% 	{ok,Req1,State}.

handle(<<"GET">>,Req,State) ->
	{ok,Req,State}.
