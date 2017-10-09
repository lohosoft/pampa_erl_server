{application, 'pampa_erl_server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['pampa_api_handler','pampa_erl_server_app','pampa_erl_server_sup']},
	{registered, [pampa_erl_server_sup]},
	{applications, [kernel,stdlib,cowboy,sync]},
	{mod, {pampa_erl_server_app, []}},
	{env, []}
]}.