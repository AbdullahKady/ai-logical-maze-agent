% ========================KNOWLEDGE BASE======================== %
grid_dimensions(5, 5).
ironman_position(1, 2, s0).
thanos(3, 4, s0).
% This should be generated automatically via Java as well.
snapped_helper(S) :-
    thanos(X, Y, s0),
    ironman_position([[]],
                     [[1, 1], [2, 1], [2, 2], [3, 3]],
                     X,
                     Y,
                     I_S),
    S=result(snap, I_S).
% ========================KNOWLEDGE BASE======================== %

% ========================CONSTANTS======================== %
move(up, 1, 0).
move(down, -1, 0).
move(left, 0, 1).
move(right, 0, -1).
% ========================CONSTANTS======================== %

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

% ========================PROBLEM======================== %
snapped(S) :-
    snapped_helper(S).

ironman_position(_, [], X, Y, s0) :-
    ironman_position(X, Y, s0).

ironman_position(STATES, STONES, X, Y, result(ACTION, S)) :-
    member([X, Y], STONES),
    ACTION=collect,
    delete(STONES, [X, Y], NEW_STONES),
    ironman_position(STATES, NEW_STONES, X, Y, S).

ironman_position(STATES, STONES, X, Y, result(A, S)) :-
    move(A, X_D, Y_D),
    Z is X_D+X,
    W is Y_D+Y,
    is_valid_position(X, Y),
    T=[X, Y],
    not(member(T, STATES)),
    add_tail(STATES, T, NEW_STATES),
    ironman_position(NEW_STATES, STONES, Z, W, S).
% ========================PROBLEM======================== %