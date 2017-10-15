-module(pampa_api_handler).
-behavior(cowboy_handler).
-include("../include/mylog.hrl").

-export([init/2]).

init(Req, State) ->

	% parse params ========
	#{
		<<"nonce">> 			:= 		Nonce,
		<<"timestamp">> 		:= 		Timestamp,
		% not use following yet ==========
		% <<"openid">> 			:= 		OpenID,
		% <<"encrypt_type">> 	:= 		EncryptType,
		% <<"msg_signature">> 	:= 		MsgSignature,
		<<"signature">> 		:= 		Signature

	} = 
		maps:from_list(cowboy_req:parse_qs(Req)),
	

	Check = wechat_utils:check(binary_to_list(Signature), binary_to_list(Timestamp), binary_to_list(Nonce)),
	?myPrint("check",Check),

	if
		Check == false ->
			{error,Req,State};
		true ->
			Method = cowboy_req:method(Req),
			handle(Method,Req,State)
	end.


handle(<<"GET">>,Req,State) ->
	Req1 = cowboy_req:reply(
		200,
		#{<<"content-type">> => <<"text/plain">>},
		<<"get echo">>,
		Req
		),
	{ok,Req1,State};
handle(<<"POST">>,Req,State) ->
	% ?myPrint("post req",Req),
	{ok, Body, Req1} = cowboy_req:read_body(Req),
	RootElement = exomler:decode(Body),
	{_Tag, _Attrs, Content} = RootElement,
	% remove [] between K,V made by exomler ======================  TODO
	Content1 = [{K,V} || {K,_emptylist,V} <- Content],
	Content2 = maps:from_list(Content1),
	% ?myPrint("Content",Content2),

	[MsgType] = maps:get(<<"MsgType">>,Content2),
	?myPrint('MsgType',MsgType),
	case MsgType of
		<<"video">> ->
			ResData = utake1_itake1:handle('VIDEO',Content2),
			?myPrint("video reply data",ResData),
			{ok,Req1,State};
		<<"image">> ->
			ResData = utake1_itake1:handle('IMAGE',Content2),
			{ok,Req1,State};
		_NotYetForOtherMsgType ->
			{ok,Req1,State}
	end;

handle(_,Req,State) ->
	cowboy_req:reply(405,Req,State).





% for pass wechat token identification ==================
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
