-module (utake1_itake1).

-include("../../include/mylog.hrl").

-export ([handle/3]).

handle(Type,Content,Token0) ->
	[MediaId] 			= 		maps:get(<<"MediaId">>,Content),

	% +++++++++++++++++++++++++++++++++++++++++++ bakcup
	% [ThumbMediaId] 		= 		maps:get(<<"ThumbMediaId">>,Content),
	% [CreateTime] 		= 		maps:get(<<"CreateTime">>,Content),
	% [MsgId]				=		maps:get(<<"MsgId">>,Content),
	% [ToUserName]		=		maps:get(<<"ToUserName">>,Content),
	% [FromUserName]		=		maps:get(<<"FromUserName">>,Content),
	% +++++++++++++++++++++++++++++++++++++++++++++++

	% Token = wechat_utils:getToken(),
	% ?myPrint("token",Token0),
	
	case wechat_utils:getMediaData(Type,binary_to_list(Token0),binary_to_list(MediaId)) of
		{'ERROR',_} ->
			?myPrint("expired or wrong token",Token0),
			Token1 = wechat_utils:getToken(),
			?myPrint("new good token",Token1),
			handle(Type,Content,Token1);
		{ok,DataList} ->
			{Token0,DataList}
	end.


