:- dynamic mina/2.
:- dynamic valor/3.
:- dynamic aberta/2.
:- dynamic arquivo_carregado.

:- ['mina'].
:- ['ambiente'].

tamanho(TAM) :- TAM is 3.

posicao(I,J) :-
        arquivo_carregado,
		open('jogo.pl', append, String),
        posicao(I, J, String).

posicao(I,J) :-
        open('jogo.pl', write, String),
        assert(arquivo_carregado),
        posicao(I, J, String).

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
								not(aberta(I,J)),
								valor(I,J,K),
								K=0, !,
								swritef(Aux, 'Casa(%d,%d) = %d\n', [I, J, K]),
								write(String, Aux),
								print(Aux),
								assert(aberta(I,J)),
								posicao_adj(I,J, String, _).

posicao(I,J, String) :-
							    not(aberta(I,J)),
							    valor(I,J,K), !,
								swritef(Aux, 'Casa(%d,%d) = %d\n', [I,J,K]),
								write(String, Aux),
								assert(aberta(I,J)),
								print(Aux).

posicao_adj(I, J, String, left) :-
						J1 is J - 1,
						J1 > 0,
						not(mina(I,J1)),
						posicao(I,J1, String).


posicao_adj(I, J, String, right) :-
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						not(mina(I,J1)),
						posicao(I,J1, String).


posicao_adj(I, J, String, bottom) :-
						I1 is I + 1,
						tamanho(TAM),
						I1 =< TAM,
						not(mina(I1,J)),
						posicao(I1,J, String).


posicao_adj(I, J, String, top) :-
						I1 is I - 1,
						tamanho(TAM),
						I1 > 0,
						not(mina(I1,J)),
						posicao(I1,J, String).


posicao_adj(I, J, String, topright) :-
						I1 is I - 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						I1 > 0,
						not(mina(I1,J1)),
						posicao(I1,J1, String).



posicao_adj(I, J, String, bottomright) :-
						I1 is I + 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						I1 =< TAM,
						not(mina(I1,J1)),
						posicao(I1,J1, String).


posicao_adj(I, J, String, topleft) :-
						I1 is I - 1,
						J1 is J - 1,
						J1 > 0,
						I1 > 0,
						not(mina(I1,J1)),
						posicao(I1,J1, String).


posicao_adj(I, J, String, bottomleft) :-
						I1 is I + 1,
						J1 is J - 1,
						tamanho(TAM),
						J1 > 0,
						I1 =< TAM,
						not(mina(I1,J1)),
						posicao(I1,J1, String).