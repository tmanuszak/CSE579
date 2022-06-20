%%%%%%%%%%%%%%%%%%%
% File: blocks-scenario.lp
%%%%%%%%%%%%%%%%%%%

block(1..6).

% initial state
% :- not on(1,2,0; 2,table,0; 3,4,0; 4,table,0; 5,6,0; 6,table,0).

% goal
% :- not on(3,2,m; 2,1,m; 1,table,m; 6,5,m; 5,4,m; 4,table,m).
:- not on(1,L1,0; 2,L2,0; 3,L3,0; 4,L4,0; 5,L5,0; 6,L6,0), block(L1;L2;L3;L4;L5;L6).
