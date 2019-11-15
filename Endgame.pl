% ========================FACTS======================== %
grid_dimensions(5, 5). % A fact as m x n grid
% Initial locations at state 0
% ironman_position(1, 2, [[1, 2]], s0).
ironman_position(2, 2, [[1, 1], [2, 1], [2, 2], [3, 3]], s0).
thanos(3, 4, s0).
% ========================FACTS======================== %

% ========================HELPERS======================== %
add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :-
    add_tail(T, X, L).
% ========================HELPERS======================== %
snapped(S) :-
    thanos(X, Y, s0),
    % All stones are collected.
    ironman_position(X, Y, [], I_S),
    % ironman_position(X, Y, _, I_S),
    S=result(snap, I_S).

is_valid_position(X, Y) :-
    grid_dimensions(M, N),
    X>=0,
    X<M,
    Y>=0,
    Y<N.

ironman_position(X, Y, NEW_STONES, result(ACTION, S)) :-
    member([X, Y], STONES),
    ACTION=collect,
    delete(STONES, [X, Y], NEW_STONES),
    ironman_position(X, Y, STONES, S).

ironman_position(X, Y, STONES, result(ACTION, S)) :-
    Z is X+1,
    ACTION=up,
    is_valid_position(X, Y),
    ironman_position(Z, Y, STONES, S).

ironman_position(X, Y, STONES, result(ACTION, S)) :-
    Z is X-1,
    ACTION=down,
    is_valid_position(X, Y),
    ironman_position(Z, Y, STONES, S).

ironman_position(X, Y, STONES, result(ACTION, S)) :-
    ACTION=left,
    Z is Y+1,
    is_valid_position(X, Y),
    ironman_position(X, Z, STONES, S).

ironman_position(X, Y, STONES, result(ACTION, S)) :-
    ACTION=right,
    Z is Y-1,
    is_valid_position(X, Y),
    ironman_position(X, Z, STONES, S).


% Actions list:
% left >> Y-1
% right >> Y+1
% up >> X-1
% down >>