:- dynamic mina/2.
:- dynamic valor/3.
:- dynamic aberta/2.
:- dynamic jogada.
:- dynamic arquivo_carregado.

:- ['mina'].
:- ['ambiente'].

tamanho(TAM) :- TAM is 3.

%Proximas_jogadas
posicao(I,J) :-
        arquivo_carregado,
		open('jogo.pl', append, String),
		assert(jogada),
		Swritef(Texto, '/*JOGADA %d\n*/', [length(jogada)]),
		print(Texto),
		swritef(Aux, 'posicao(%d,%d).\n', [I,J]),
		write(String, Aux),
		print(Aux),
        posicao(I, J, String, L).

%Primeira_jogada
posicao(I,J) :-
        open('jogo.pl', write, String),
        assert(arquivo_carregado),
        assert(jogada),
        swritef(Texto, '/*JOGADA 1*/.\n'), 
        write(String, Texto),
        print(Texto)
        swritef(Aux, 'posicao(%d,%d).\n', [I,J]),
        write(String, Aux),
        posicao(I, J, String, L).

posicao(I,J, String, L) :-
								mina(I,J),
								assert(aberta(I,J)),
								%swritef(Aux, 'mina(%d,%d).\n', [I, J]),
								swritef(Texto, '/*AMBIENTE*/'),
								write(String, texto),
								print(Texto),
								swritef(Aux, 'Game Over'),
								print(Aux),
								write(String, Aux),
								close(String),
								halt.
posicao(I,J, String, L) :-
								not(aberta(I,J)),
								valor(I,J,K),
								K=0, !,
								swritef(Texto, '/*AMBIENTE*/'),
								write(String, texto),
								print(Texto),
								swritef(Aux, 'valor(%d,%d,%d).\n', [I, J, K]),
								write(String, Aux),
								print(Aux),
								assert(aberta(I,J)),
								findall((I1,J1), posicao_adj(I,J, _, I1, J1), L),
								abre_casas(L, String).

posicao(I,J, String,L) :-
							    not(aberta(I,J)),
							    valor(I,J,K), !,
							    swritef(Texto, '/*AMBIENTE*/'),
							    write(String, Texto),
							    print(Texto),
								swritef(Aux, 'valor(%d,%d,%d).\n', [I,J,K]),
								write(String, Aux),
								assert(aberta(I,J)),
								print(Aux),
								abre_casas(L, String).

posicao_adj(I, J, left, I, J1) :-
						J1 is J - 1,
						J1 > 0,
						not(mina(I,J1)).


posicao_adj(I, J, right, I, J1) :-
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						not(mina(I,J1)).


posicao_adj(I, J, bottom, I1, J) :-
						I1 is I + 1,
						tamanho(TAM),
						I1 =< TAM,
						not(mina(I1,J)).


posicao_adj(I, J, top, I1, J) :-
						I1 is I - 1,
						tamanho(TAM),
						I1 > 0,
						not(mina(I1,J)).


posicao_adj(I, J, topright, I1, J1) :-
						I1 is I - 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						I1 > 0,
						not(mina(I1,J1)).



posicao_adj(I, J, bottomright, I1, J1) :-
						I1 is I + 1,
						J1 is J + 1,
						tamanho(TAM),
						J1 =< TAM,
						I1 =< TAM,
						not(mina(I1,J1)).


posicao_adj(I, J, topleft, I1, J1) :-
						I1 is I - 1,
						J1 is J - 1,
						J1 > 0,
						I1 > 0,
						not(mina(I1,J1)).


posicao_adj(I, J, bottomleft, I1, J1) :-
						I1 is I + 1,
						J1 is J - 1,
						tamanho(TAM),
						J1 > 0,
						I1 =< TAM,
						not(mina(I1,J1)).

abre_casas([], _).
abre_casas([(I,J)|L], String) :-
						posicao(I,J, String, L). 						
