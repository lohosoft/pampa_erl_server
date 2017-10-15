-module (utake1_itake1).

-include("../../include/mylog.hrl").

-export ([handle/2]).

handle(Type,Content) ->
	[MediaId] 			= 		maps:get(<<"MediaId">>,Content),
	% [ThumbMediaId] 		= 		maps:get(<<"ThumbMediaId">>,Content),
	% [CreateTime] 		= 		maps:get(<<"CreateTime">>,Content),
	% [MsgId]				=		maps:get(<<"MsgId">>,Content),
	% [ToUserName]		=		maps:get(<<"ToUserName">>,Content),
	% [FromUserName]		=		maps:get(<<"FromUserName">>,Content),
	Token = wechat_utils:getToken(),
	?myPrint("token",Token),
	case Type of
		'VIDEO' ->
			VideoData = wechat_utils:getMediaData(
									'VIDEO',
									binary_to_list(Token),
									binary_to_list(MediaId)
									),
			% ?myPrint("video raw data",VideoData),
			VideoData;
		'IMAGE' ->
			ImgData = wechat_utils:getMediaData(
									'IMAGE',
									binary_to_list(Token),
									binary_to_list(MediaId)		
									),
			% ?myPrint("image raw data",ImgData),
			ImgData

	end.


