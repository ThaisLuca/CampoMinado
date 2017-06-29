:- dynamic mina/2.
:- dynamic tamanho/1.
:- dynamic ambiente/3.


inicio :-
		['mina'],
		['ambiente'],
		['programa1'].

abre_casa(I, J) :- mina(I,J),
		   writeln('BOOOOOMM!'),
		   writeln('Game Over').
