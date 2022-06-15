%%%%%%%%%% objects and attributes %%%%%%%%%%%%%
% node (cell in warehouse)
nodeAt(N, X, Y) :-
    init(object(node,N), value(at, pair(X,Y))).

% The only movements allowed
move(1,0; -1,0; 0,1; 0,-1).

% Give location of all 

% (at most one can be true (could do nothing)) robot R moves horizontal or vertical if...
0{occurs(object(robot, R),move(DX, DY), T)}1 :-
        % There is a node there
        init(object(node,N),value(at,pair(X,Y))), occurs(object(robot, R),
