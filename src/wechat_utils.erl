-module(wechat_utils).

-include("../include/config.hrl").
-include("../include/wechat.hrl").
-include("../include/mylog.hrl").

-import(lists, [nth/2, map/2, foldl/3]).
% -import(erlang,[integer_to_list/2, list_to_integer/2]).

-export([check/3]).

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
    % ?myPrint("sha1",sha1:hexstring(TmpStr)),
    % ?myPrint("signature",Signature),
    string:equal(ShaStr,Signature).

    


%%====================================================================
%% Internal functions
%%====================================================================


% medias tools
%%====================================================================

% get_media(AccessToken, MediaId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/media/get?access_token="++AccessToken++"&media_id="++MediaId),
%     http_get(URL).

% add_news(AccessToken, News) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/add_news?access_token="++AccessToken),
%     NewsBinary = list_to_binary(News),
%     http_post(URL, NewsBinary).

% get_material(AccessToken, MediaId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/get_material?access_token="++AccessToken),
%     MediaIdBinary = list_to_binary(MediaId),
%     http_post(URL, MediaIdBinary).

% delete_material(AccessToken, MediaId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/del_material?access_token="++AccessToken),
%     MediaIdBinary = list_to_binary(MediaId),
%     http_post(URL, MediaIdBinary).

% update_news(AccessToken, News) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/update_news?access_token="++AccessToken),
%     NewsBinary = list_to_binary(News),
%     http_post(URL, NewsBinary).

% get_material_count(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/get_materialcount?access_token="++AccessToken),
%     http_get(URL).

% get_batch_material(AccessToken, Query) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/material/batchget_material?access_token="++AccessToken),
%     QueryBinary = list_to_binary(Query),
%     http_post(URL, QueryBinary).



% messages tools
%%====================================================================

% add_kf_account(AccessToken, Account) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/customservice/kfaccount/add?access_token="++AccessToken),
%     AccountBinary = list_to_binary(Account),
%     http_post(URL, AccountBinary).

% update_kf_account(AccessToken, Account) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/customservice/kfaccount/update?access_token="++AccessToken),
%     AccountBinary = list_to_binary(Account),
%     http_post(URL, AccountBinary).

% delete_kf_account(AccessToken, Account) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/customservice/kfaccount/del?access_token="++AccessToken),
%     AccountBinary = list_to_binary(Account),
%     http_post(URL, AccountBinary).

% get_kf_list(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/customservice/getkflist?access_token="++AccessToken),
%     http_get(URL).

% send_message(AccessToken, Message) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/custom/send?access_token="++AccessToken),
%     MessageBinary = list_to_binary(Message),
%     http_post(URL, MessageBinary).

% send_message_by_group(AccessToken, Message) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/mass/sendall?access_token="++AccessToken),
%     MessageBinary = list_to_binary(Message),
%     http_post(URL, MessageBinary).

% send_message_by_openid_list(AccessToken, Message) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/mass/send?access_token="++AccessToken),
%     MessageBinary = list_to_binary(Message),
%     http_post(URL, MessageBinary).

% delete_message(AccessToken, MessageId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/mass/delete?access_token="++AccessToken),
%     MessageIdBinary = list_to_binary(MessageId),
%     http_post(URL, MessageIdBinary).

% get_info_of_message(AccessToken, MessageId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/mass/get?access_token="++AccessToken),
%     MessageIdBinary = list_to_binary(MessageId),
%     http_post(URL, MessageIdBinary).

% set_industry_for_template(AccessToken, Industry) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/template/api_set_industry?access_token="++AccessToken),
%     IndustryBinary = list_to_binary(Industry),
%     http_post(URL, IndustryBinary).

% get_industry(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/template/get_industry?access_token="++AccessToken),
%     http_get(URL).

% get_template_id(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/template/api_add_template?access_token="++AccessToken),
%     http_get(URL).

% get_private_template_list(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/template/get_all_private_template?access_token="++AccessToken),
%     http_get(URL).

% delete_private_template(AccessToken, TemplateId) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/template/del_private_template?access_token="++AccessToken),
%     TemplateIdBinary = list_to_binary(TemplateId),
%     http_post(URL, TemplateIdBinary).

% send_template_message(AccessToken, Message) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/message/template/send?access_token="++AccessToken),
%     MessageBinary = list_to_binary(Message),
%     http_post(URL, MessageBinary).

% get_autoreply_info(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/get_current_autoreply_info?access_token="++AccessToken),
%     http_get(URL).



% menus
%%====================================================================

% create(AccessToken, Menu) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/menu/create?access_token="++AccessToken),
%     MenuBinary = list_to_binary(Menu),
%     http_post(URL, MenuBinary).

% get(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/menu/get?access_token="++AccessToken),
%     http_get(URL).

% delete(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/menu/delete?access_token="++AccessToken),
%     http_get(URL).

% add_conditional(AccessToken, MenuConditional) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/menu/addconditional?access_token="++AccessToken),
%     MenuConditionalBinary = list_to_binary(MenuConditional),
%     http_post(URL, MenuConditionalBinary).

% get_info(AccessToken) ->
%     URL = list_to_binary(?API_URL_PREFIX ++ "/cgi-bin/get_current_selfmenu_info?access_token="++AccessToken),
%     http_get(URL).



% utils
%%====================================================================


% http_get(URL) ->
%     Method = get,
%     Headers = [{<<"Content-Type">>, <<"application/json">>}],
%     Payload = <<>>,
%     Options = [],
%     {ok, _StatusCode, _RespHeaders, ClientRef} = hackney:request(Method, URL, Headers, Payload, Options),
%     {ok, Body} = hackney:body(ClientRef),
%     Response = jiffy:decode(Body),
%     Response.

% http_post(URL, Body) ->
%     Method = post,
%     ReqHeaders = [{<<"Content-Type">>, <<"application/json">>}],
%     {ok, ClientRef} = hackney:request(Method, URL, ReqHeaders, stream, []),
%     ok  = hackney:send_body(ClientRef, Body),
%     {ok, _Status, _Headers, ClientRef} = hackney:start_response(ClientRef),
%     {ok, Body} = hackney:body(ClientRef),
%     Response = jiffy:decode(Body),
%     Response.


