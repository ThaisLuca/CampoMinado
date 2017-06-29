:- dynamic mina/3.


inicio :-
		open('ambiente.pl', write, String),
		['mina'],
		anda(1, 1, String),
		close(String),
		halt.

tamanho(TAM) :- TAM is 3.

checa_casa(I, J, left) :-
						J1 is J - 1,
						mina(I, J1).
checa_casa(I, J, right) :-
						J1 is J + 1,
						mina(I, J1).
checa_casa(I, J, bottom) :-
						I1 is I + 1,
						mina(I1, J).
checa_casa(I, J, top) :-
						I1 is I - 1,
						mina(I1, J).
checa_casa(I, J, topright) :-
						I1 is I - 1,
						J1 is J + 1,
						mina(I1, J1).
checa_casa(I, J, bottomright) :-
						I1 is I + 1,
						J1 is J + 1,
						mina(I1, J1).
checa_casa(I, J, topleft) :-
						I1 is I - 1,
						J1 is J - 1,
						mina(I1, J1).
checa_casa(I, J, bottomleft) :-
						I1 is I + 1,
						J1 is J - 1,
						mina(I1, J1).

anda(I, J, String) :-
				not(mina(I,J)),
				!,
				findall(X, checa_casa(I,J,X), Z),
				length(Z, K),
				swritef(Aux, 'valor(%d,%d,%d).\n', [I, J, K]),
				write(String, Aux),
				proxima_casa(I, J, N_I, N_J),
				quebra_linha(I, N_I, String),
				anda(N_I, N_J, String).

anda(I, J, String) :-
					proxima_casa(I, J, N_I, N_J),
					quebra_linha(I, N_I, String),
					anda(N_I, N_J, String).

proxima_casa(I, J, I, J) :-
								tamanho(TAM),
								I = TAM,
								J = TAM,
								!,
								halt.

proxima_casa(I, J, N_I, N_J) :-
								tamanho(TAM),
								J > 0,
								J < TAM,
								I =< TAM,
								I > 0,
								!,
								N_I is I,
								N_J is J + 1.
proxima_casa(I, _, N_I, 1) :-
								tamanho(TAM),
								I > 0,
								I =< TAM,
								!,
								N_I is I + 1.

quebra_linha(I, N_I, String) :-
								not(I = N_I),
								write(String, '\n').

quebra_linha(_, _, _).

