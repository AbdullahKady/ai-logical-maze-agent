grid_dimensions(5, 5).
ironman_position(1, 2, s0).
thanos(3, 4, s0).
snapped_helper(S) :-
	thanos(X, Y, s0),
	ironman_position([[]], [[1, 1], [2, 1], [2, 2], [3, 3]], X, Y, I_S),
	S=result(snap, I_S).

