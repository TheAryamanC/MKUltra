launch_conversation(Parent, Partner, Event) :-
   begin_child_concern(Parent, conversation, 1, Child,
		       [ Child/partner/Partner,
			 Child/initial_history/Event ]),
   (Partner \= player -> assert(Child/location_bids/Partner:200);true).

conversation_handler_task(Concern, Input) :-
   kill_children(Concern),
   Concern/partner/P,
   start_task(Concern, Input, 100, T, [T/partner/P]).

conversation_is_idle(C) :-
   \+ ( still_speaking_to_partner(C) ; partner_still_speaking_to_me(C) ).

still_speaking_to_partner(C) :-
   C/concerns/_.

partner_still_speaking_to_me(Conversation) :-
   Conversation/partner/Partner,
   elroot(Partner, Root),
   descendant_concern_of(Root, C),
   C/type:conversation,
   C/partner/ $me,
   C/concerns/_.

on_enter_state(start, conversation, C) :-
   C/initial_history/Event,
   ( Event = greet($me, _) ->
       assert(C/greeted)
       ;
       conversation_handler_task(C, respond_to_dialog_act(Event)) ).

% KLUGE: when polling for actions, check if the conversation is idle, and if so try to say something.
propose_action(_, conversation, C) :-
   conversation_is_idle(C),
   conversation_handler_task(C, say_something),
   fail.