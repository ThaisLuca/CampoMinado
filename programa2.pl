:- dynamic mina/2.
:- dynamic valor/3.
:- dynamic aberta/2.

inicio(I,J) :-
		open('jogo.pl', write, String),
		['mina'],
		['ambiente'].


tamanho(TAM) :- TAM is 3.


posicao(I,J, String) :-
								mina(I,J),
								assert(aberta(I,J)),
								swritef(Aux, 'mina(%d,%d).\n', [I, J]),
								write(String, Aux),
								print('BOOOOM!'),
								print(Aux),
								print('Game Over'),
								close(String),
								halt.
posicao(I,J, String) :-
								valor(I,J,K),
								K=0, !, not(aberta(I,J)),
								swritef(Aux, 'Casa(%d,%d) = %d\n', [I, J, K]),
								write(String, Aux),
								print(Aux),
								assert(aberta(I,J)),
								findall(X, posicao_adj(I,J, String, X), Lista).

posicao(I,J, String) :- 
								valor(I,J,K), not(aberta(I,J)),
								swritef(Aux, ('Casa(%d,%d) = %d\n', [I,J,K])),
								write(String, Aux),
								print(Aux), assert(aberta(I,J)).

posicao_adj(_, _, _, _).
posicao_adj(I, J, String, left) :-
						J1 is J - 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I =< TAM,
						I > 0,
						!, not(mina(I,J1)),
						posicao(I,J1, String).


posicao_adj(I, J, String, right) :-
						J1 is J + 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I =< TAM,
						I > 0,
						!, not(mina(I,J1)),
						posicao(I,J1, String).


posicao_adj(I, J, String, bottom) :-
						I1 is I + 1,
						tamanho(TAM),
						J > 0,
						J =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J)),
						posicao(I1,J, String).


posicao_adj(I, J, String, top) :-
						I1 is I - 1,
						tamanho(TAM),
						J > 0,
						J =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J)),
						posicao(I1,J, String).


posicao_adj(I, J, String, topright) :-
						I1 is I - 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J1)),
						posicao(I1,J1, String).



posicao_adj(I, J, String, bottomright) :-
						I1 is I + 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J1)),
						posicao(I1,J1, String).


posicao_adj(I, J, String, topleft) :-
						I1 is I - 1,
						J1 is J - 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J1)),
						posicao(I1,J1, String).


posicao_adj(I, J, String, bottomleft) :-
						I1 is I + 1,
						J1 is J - 1,
						tamanho(TAM),
						J1 > 0,
						J1 =< TAM,
						I1 =< TAM,
						I1 > 0,
						!, not(mina(I1,J1)),
						posicao(I1,J1, String).