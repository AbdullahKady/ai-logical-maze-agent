:- include('KB1.pl').
% ========================HELPERS======================== %
% True if X&Y are within the grid's boundraies.
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
% Movements are represented as constant predicates/facts to avoid
% the repetition of the movement logic in the successor axioms.
move(up, 1, 0).
move(down, -1, 0).
move(left, 0, 1).
move(right, 0, -1).
% ========================MOVES======================== %

% ========================PROBLEM======================== %
snapped(S) :-
    % snapped predicate simply snapped_ids, which will query the snapped in an IDS fashion (increasing depth limit)
    snapped_ids(S, 0).

snapped_ids(S, L) :-
    call_with_depth_limit(snapped_helper(S), L, RESULT),
    % Prolog will populate the result with the following constant value if the depth limit is reached.
    RESULT\=depth_limit_exceeded.

snapped_ids(S, L) :-
    X is L+1,
    snapped_ids(S, X).

snapped_helper(S) :-
    thanos(X, Y, s0),
    S=result(snap, I_S),
    % All stones are collected, and IronMan is at the same X, Y as thanos.
    ironman_position(X, Y, [], I_S).

% Stone collection axiom: The resulting suituation will be in the same X&Y
% position, the difference will be in the stones list (the one @X,Y will be removed).
ironman_position(X, Y, NEW_STONES, result(ACTION, S)) :-
    ironman_position(X, Y, STONES, S),
    member([X, Y], STONES),
    ACTION=collect,
    delete(STONES, [X, Y], NEW_STONES).

% Movement axiom (with X&Y movements, and the action permuation "up, down etc.")
ironman_position(X, Y, STONES, result(ACTION, S)) :-
    move(ACTION, X_FACTOR, Y_FACTOR),
    PREVIOUS_X is X+X_FACTOR,
    PREVIOUS_Y is Y+Y_FACTOR,
    is_valid_position(X, Y),
    ironman_position(PREVIOUS_X, PREVIOUS_Y, STONES, S).
% ========================PROBLEM======================== %
