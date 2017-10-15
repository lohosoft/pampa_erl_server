{application, 'pampa_erl_server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['myutils','pampa_api_handler','pampa_erl_server_app','pampa_erl_server_sup','sha1','utake1_itake1','wechat_utils']},
	{registered, [pampa_erl_server_sup]},
	{applications, [kernel,stdlib,cowboy,sync,exomler,ibrowse,jiffy]},
	{mod, {pampa_erl_server_app, []}},
	{env, []}
]}.