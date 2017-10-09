-module(pampa_api_handler).
-behavior(cowboy_handler).

-export([init/2]).

init(Req, State) ->
	% Qs = cowboy_req:parse_qs(Req),
	% io:format("~p",[Qs]),
	#{
		<<"nonce">> := Nonce,
		<<"timestamp">> := Timestamp,
		% <<"openid">> := OpenID,
		% <<"encrypt_type">> := EncryptType,
		% <<"msg_signature">> := MsgSignature,
		<<"signature">> := Signature

	} = 
		maps:from_list(cowboy_req:parse_qs(Req)),
	io:format("~p \n",[Signature]),
	io:format("~p \n",[Timestamp]),
	io:format("~p \n",[Nonce]),
	

	Check = wechat_utils:check(binary_to_list(Signature), binary_to_list(Timestamp), binary_to_list(Nonce)),

	io:format("check resutl is : ~p ",[Check]),
	{ok,Req,State}.
	% if
	% 	Check == false ->
	% 		{error,Req,State};
	% 	true ->
	% 		Method = cowboy_req:method(Req),
	% 		handle(Method,Req,State)
	% end.

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
	% {ok,Req1,State}.

handle(<<"GET">>,Req,State) ->
	Req1 = cowboy_req:reply(
		200,
		#{<<"content-type">> => <<"text/plain">>},
		<<"get echo">>,
		Req
		),
	{ok,Req1,State};
handle(<<"POST">>,Req,State) ->

	io:format("~p : ~p \n",["POST Req",Req]),
	Req1 = cowboy_req:reply(
		200,
		#{<<"content-type">> => <<"text/plain">>},
		<<"post echo">>,
		Req
		),
	{ok,Req1,State};
handle(_,Req,State) ->
	cowboy_req:reply(405,Req,State).
