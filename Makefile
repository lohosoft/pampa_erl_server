PROJECT = pampa_erl_server
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy sync exomler ibrowse jiffy
dep_cowboy_commit = master
dep_exomler = git https://github.com/erlangbureau/exomler

# dep_rncryptor = git https://github.com/RNCryptor/RNCryptor-erlang
DEP_PLUGINS = cowboy sync

include erlang.mk
