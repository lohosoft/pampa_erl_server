-module(wechat_utils).

-include("../include/config.hrl").
-include("../include/wechat.hrl").
-include("../include/mylog.hrl").

-import(lists, [nth/2, map/2, foldl/3]).
% -import(erlang,[integer_to_list/2, list_to_integer/2]).

-export([check/3]).
-export ([getToken/0]).
-export ([getMediaData/3]).
-export ([decodeWechatMsg/1]).

getMediaData(Type,Token,MediaId) ->
    GetDataUrl = getDataUrl(Type,Token,MediaId),
    % ?myPrint("get data url",GetDataUrl),
    Response = ibrowse:send_req(GetDataUrl,[],get),
    % ?myPrint("get media data response",Response),

    {ok,"200",Params,RawData} = Response,
    % ?myPrint("get media data response params",Params),
    % ?myPrint("get media raw data",RawData),

    try jiffy:decode(RawData) of
        {[
            {<<"errcode">>,ErrCode},
             _Rest
        ]} ->
            {'ERROR',[ErrCode]}
    catch
        _ErrorType:_Error ->
            {ok,RawData}
    end.

    % if 
    %     (is_list(RawData)) ->
    %         {ok,RawData};
    %     false ->
    %         RawJsonData = RawData,

    %         % error code demo ===============================
    %         %  {[
    %         %     {<<"errcode">>,41001},
    %         %     {<<"errmsg">>,<<"access_token missing hint: [XDGtAa0914vr47!]">>}
    %         % ]}

    %         {[
    %             {<<"errcode">>,ErrCode},
    %             _Rest
    %         ]} = jiffy:decode(RawJsonData),

    %         {'ERROR',[ErrCode]}

    %     end.


check(Signature, Timestamp, Nonce) ->
    Token = ?WECHAT_TOKEN,
    TmpList = [Token, Timestamp, Nonce],
    TmpList2 = lists:sort(TmpList),
    TmpStr = string:join(TmpList2, ""),
    % B equals B1
    % B = erlang:md5(TmpStr),
    % B1 = crypto:hash(md5,TmpStr),
    % ?myPrint("crypto hash string",myutils:binary_to_hexstring(B1)),
    ShaStr = string:lowercase(sha1:hexstring(TmpStr)),
    % crypto:hash not working ? =========================  TODO
    % ShaStr = crypto:hash(sha,TmpStr),
    % ?myPrint("sha1",ShaStr),
    % ?myPrint("signature",Signature),
    string:equal(ShaStr,Signature).


getToken() ->
    GetTokenUrl = getAccessTokenUrl(),
    % ?myPrint("get access token url",GetTokenUrl),

    Response = ibrowse:send_req(GetTokenUrl,[],get),

    % ibrowse back data demo ==============================
    % {ok,"200",
%                        [{"Connection","keep-alive"},
%                         {"Content-Type","application/json; encoding=utf-8"},
%                         {"Date","Sun, 15 Oct 2017 00:26:40 GMT"},
%                         {"Content-Length","175"}],

%                        "{\"access_token\":\"-ptyOxCBpy-1WgHzmI-T4Z3mTXt3MQCmE3zgPeNRTVsyakTgY1c3VMK0XwN8vdAup37RjDzUqinIUjNn4hAjEbtbOihMwYiRdI6M1egreSa5CCHZ2MGnaZj7Pgc-LdRbVDLbAAAPXF\",\"expires_in\":7200}"}
    {ok,"200",_Params,JSONData} = Response,

    % ?myPrint("token in json",jiffy:decode(JSONData)),
    % jiffy decode data demo =========================

    % {[

    %   {<<"access_token">>,
%                    <<"6cEc6yAV1b22e0GfcGlQGb1gNMyIysE5grbma-KVNCWW5--tB6wgnKY2cGQ_wIggZWxrNvzeaGSd8yZn21U8UuUfIGrEhs_7NyZmWU0xCVU3ZgxvO80mWGi-D6vIrRjfFGFfADALML">>},
%           {<<"expires_in">>,7200}
%       ]}
    {[
        {<<"access_token">>,Token},
        {<<"expires_in">>,_Expire}
    ]}
        = jiffy:decode(JSONData),

    % ?myPrint("got token",Token),
    Token.


% ==========================================================
% Internal api
% ==========================================================
getAccessTokenUrl() ->
    "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" ++ 
    ?WECHAT_APPID ++ 
    "&secret=" ++ 
    ?WECHAT_APPSECRET.

getDataUrl('VIDEO',Token,MediaId) ->
    "http://api.weixin.qq.com/cgi-bin/media/get?access_token=" ++ 
    Token ++ 
    "&media_id=" ++ 
    MediaId;
getDataUrl(_OtherType,Token,MediaId) ->
    "https://api.weixin.qq.com/cgi-bin/media/get?access_token=" ++ 
    Token ++ 
    "&media_id=" ++ 
    MediaId.




decodeWechatMsg(Encrypt) ->
    ?myPrint("decodeWechatMsg got data",Encrypt),

    AESKey = base64:decode_to_string(?WECHAT_ENCODING_AESKEY ++ "="),
    ?myPrint("aeskey",term_to_binary(AESKey)),
    % AESMsg = base64:decode_to_string(Encrypt),
    AESMsg = rncryptor:decrypt(term_to_binary(AESKey),Encrypt),
    ?myPrint("aesmsg",AESMsg),

    % RandMsg = crypto:block_decrypt(aes_cbc256,AESKey,AESMsg),
    % RandMsg.
    ok.
