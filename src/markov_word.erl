%%%-------------------------------------------------------------------
%%% @author amir
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Sep 2017 12:35
%%%-------------------------------------------------------------------
-module(markov_word).
-author("amir").

add_word_list(Words, Word) ->
  [Word | Words].

pick_next_word(Words) ->
  pick_random(Words).

pick_random(List) ->
  Length = length(List),
  Index = random:uniform(Length),
  lists:nth(Index,List).

%% API
-export([]).
