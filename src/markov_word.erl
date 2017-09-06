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

add_word_to_list(Words, Word) ->
  [Word | Words].

pick_next_word(Words) ->
  pick_random(Words).

pick_random(List) ->
  Length = length(List),
  Index = random:uniform(Length),
  lists:nth(Index,List).

find_proccess_for_word(Word) ->
  WordKey = get_registered_name_for_word(Word),
  case whereis(WordKey) of
    undefined -> register_word(WordKey);
    Pid when is_pid(Pid) -> Pid
  end.

add_following_word(Word, FollowingWord) ->
  WordPid = find_process_for_word(Word),
  gen_server(WordPid, {add_following_word,
                       FollowingWord}).

pick_next_word_after(Word) ->
  WordPid = find_proccess_for_word(Word),
  gen_server(WordPid, {WordPid, {pick_next_word}}).

handle_call({add_following_word, Word}, _From,
             #state{following_words=FollowingWords}) ->
  NextState = #state{following_words=
                    add_word_to_list(FollowingWords, Word)},
  {reply, ok, NextState};
handle_call({pick_next_word}, _From,
            State=#state{following_words=FollowingWords}) ->
  Reply = pick_next_word(FollowingWords),
  {reply, Reply, State}.

register_word(Word) ->
  {ok, Pid} = markov_word_sup:start_child(Word),
  Pid.




%% API
-export([]).
