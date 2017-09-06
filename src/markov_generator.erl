%%%-------------------------------------------------------------------
%%% @author amir
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Sep 2017 12:34
%%%-------------------------------------------------------------------
-module(markov_generator).
-author("amir").

tokenize(Text) ->
  string:tokens(Text, " \t\n").

parse_text(Text) ->
  [FirstWord | Words] = tokenize(Text),
  load_words(FirstWord, Words).

load_words(_Words, []) ->
  ok;
load_words(Word, [Following | Words]) ->
  markov_word:add_following_word(Word, Following),
  load_words(Following, Words).

%% API
-export([]).
