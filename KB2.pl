grid_dimensions(5, 5).
ironman_position(2, 2, s0).
thanos(4, 4, s0).
snapped_helper(S) :-
	thanos(X, Y, s0),
	ironman_position([[]], [[1, 2], [2, 1], [3, 2], [3, 3]], X, Y, I_S),
	S=result(snap, I_S).

