%%%%%%%%%% OBJECTS AND LOCATIONS %%%%%%%%%%%%%
% Here we define objects and object location (if it moves)

% node (cell in warehouse)
node(N,X,Y) :- init(object(node,N), value(at, pair(X,Y))).

% highway (fast cell in warehouse)
highway(H,X,Y) :- init(object(highway,H), value(at, pair(X,Y))).

% picking station
pickStation(P,X,Y) :- init(object(pickingStation, P), value(at, pair(X,Y))).

% robot and robot's location
robot(R) :- init(object(robot, R), value(at, pair(X,Y))).
robotLocation(R,X,Y,0) :- init(object(robot,R), value(at, pair(X,Y))), 
  node(N,X,Y).

% shelf 
shelf(S) :- init(object(shelf, S), value(at, pair(X,Y))).
shelfLocation(S,X,Y,0) :- init(object(shelf, S), value(at, pair(X,Y))), 
  node(N,X,Y).

% products
productOnShelf(P,S,U,0) :- init(object(product, P), value(on, pair(S,U))).

% order
order(O,P,U,0) :- init(object(order, O), value(line, pair(P,U))).
deliverTo(O,P) :- init(object(order, O), value(pickingStation,P)).

%%%%%%%%%%%%%%%%%%%%%% MOVING %%%%%%%%%%%%%%%%%%%%%%%%%%%
% move options
move(1,0; -1,0; 0,1; 0,-1).

% must be in the warehouse
:- robotLocation(R,X,Y,T), not node(_, X, Y).

% one robot per node
:- robotLocation(R1,X,Y,T), robotLocation(R2,X,Y,T), R1!=R2.

% robot movement is exogenous
{occurs(object(robot,R), move(X,Y), T)} :- robot(R), move(X,Y), T=1..m.

% direct effect
robotLocation(R,X + X1,Y + Y1,T) :- occurs(object(robot,R), move(X1,Y1), T), robotLocation(R,X,Y,T-1), T=1..m.

% uniqueness and existence
:- not {robotLocation(R,X,Y,T):node(N,X,Y)}=1, robot(R), T=1..m.

% robots cant switch nodes (note, serializability is not required)
:- robotLocation(R1,X1,Y1,T), robotLocation(R2,X2,Y2,T),
  robotLocation(R1,X2,Y2,T-1), robotLocation(R2,X1,Y1,T-1), R1!=R2.


%%%%%%%%%%%%%%%% LAWS OF INERTIA %%%%%%%%%%%%%%%%%%%%
{robotLocation(R,X,Y,T)} :- robotLocation(R,X,Y,T-1), T=1..m.

%%%%%%%%%%%%%%%% AXIOMS %%%%%%%%%%%%%%%%%%%%%%%
% robot can only do one thing at a time
:- occurs(object(robot, R), A1, T), occurs(object(robot, R), A2, T), A1!=A2.
