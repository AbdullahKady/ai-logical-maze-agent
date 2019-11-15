% ========================FACTS======================== %
grid_dimensions(5, 5). % A fact as m x n grid
% Initial locations at state 0
ironman_position(0, 0, [[1, 1], [2, 1], [2, 2], [3, 3]], s0).
thanos(3, 4, s0).
% ========================FACTS======================== %

% ========================HELPERS======================== %
add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :-
    add_tail(T, X, L).

is_valid_position(X, Y) :-
    grid_dimensions(M, N),
    X>=0,
    X<M,
    Y>=0,
    Y<N.

% delete(SRC, ELM, RES)
delete([ELM|T], ELM, T).
delete([H|T], ELM, [H|REST]) :-
    delete(T, ELM, REST).

% ========================HELPERS======================== %

% ========================MOVES======================== %
move(up, 1, 0).
move(down, -1, 0).
move(left, 0, 1).
move(right, 0, -1).
% ========================MOVES======================== %

% ========================PROBLEM======================== %
snapped(S) :-
    thanos(X, Y, s0),
    % All stones are collected.
    ironman_position(X, Y, [], I_S),
    S=result(snap, I_S).

ironman_position(X, Y, NEW_STONES, result(ACTION, S)) :-
    member([X, Y], STONES),
    ACTION=collect,
    delete(STONES, [X, Y], NEW_STONES),
    ironman_position(X, Y, STONES, S).

ironman_position(X, Y, STONES, result(ACTION, S)) :-
    move(ACTION, X_FACTOR, Y_FACTOR),
    PREVIOUS_X is X+X_FACTOR,
    PREVIOUS_Y is Y+Y_FACTOR,
    is_valid_position(X, Y),
    ironman_position(PREVIOUS_X, PREVIOUS_Y, STONES, S).
% ========================PROBLEM======================== %
