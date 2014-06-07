%% contracted_form(?UncontractedList, ?ContractedList) is det
%  True when UncontractedList is the expansion of the contractions
%  in ContractedList.
contracted_form([ ], [ ]).
contracted_form([X, Y | UncontractedTail], [Z | ContractedTail]) :-
	contraction(X, Y, Z), !,
	contracted_form(UncontractedTail, ContractedTail).
contracted_form([A | UncontractedTail], [A | ContractedTail]) :-
	contracted_form(UncontractedTail, ContractedTail).
	
%% contraction(?First, ?Second, ?Contraction)
%  Contraction is the single-word contraction of [First, Second].
contraction(do, not, 'don''t').
contraction(does, not, 'doesn''t').
contraction(will, not, 'won''t').
contraction(have, not, 'haven''t').
contraction(has, not, 'hasn''t').
contraction(had, not, 'hadn''t').
contraction(is, not, 'isn''t').
contraction(are, not, 'aren''t').

contraction('I', am, 'I''m').
contraction(you, are, 'you''re').
contraction(he, is, 'he''s').
contraction(she, is, 'she''s').
contraction(we, are, 'we''re').
contraction(they, are, 'they''re').