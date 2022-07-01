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
robotLocation(R,X + X1,Y + Y1,T) :- occurs(object(robot,R), move(X1,Y1), T), 
  robotLocation(R,X,Y,T-1), T=1..m.

% uniqueness and existence
:- not {robotLocation(R,X,Y,T):node(N,X,Y)}=1, robot(R), T=1..m.

% robots cant switch nodes (note, serializability is not required)
:- robotLocation(R1,X1,Y1,T), robotLocation(R2,X2,Y2,T),
  robotLocation(R1,X2,Y2,T-1), robotLocation(R2,X1,Y1,T-1), R1!=R2.

%%%%%%%%%%%%%% SHELVING %%%%%%%%%%%%%%%%%%%
% shelves cant be on highways, unless carried
:- shelfLocation(S,X,Y,T), highway(H,X,Y), not carry(R,S,T), robot(R), T=1..m.

% shelf cant be on two different nodes
:- 2{shelfLocation(S,X,Y,T):node(N,X,Y)}, shelf(S), T=1..m.

% No two shelves on one node
:- 2{shelfLocation(S,X,Y,T):shelf(S)}, node(N,X,Y), T=1..m.

% no shelf carried by two different robots
:- 2{carry(R,S,T):robot(R)}, shelf(S), T=1..m.

% direct effect of carried movement
shelfLocation(S,X+DX,Y+DY,T) :- robotLocation(R,X,Y,T-1), carry(R,S,T-1), occurs(object(robot,R), move(DX,DY), T), T=1..m.

% If we were carrying and didnt put down, we should still carry
:- carry(R,S,T-1), not carry(R,S,T), not putdown(R,S,T), T=1..m.

% uniqueness and existence of shelf location
:- not {shelfLocation(S,X,Y,T):node(N,X,Y)}=1, shelf(S), T=1..m.

%%%%%%%%%%% PICKUP %%%%%%%%%%%%%
% pickup is exogenous
{pickup(R,S,T):shelf(S)}1 :- robot(R), T=1..m.
occurs(object(robot,R), pickup, T) :- pickup(R,S,T).

% Cant pickup from 2 different robots
:- 2{pickup(R,S,T):robot(R)}, shelf(S), T=1..m.

% cant pickup a shelf, if you already have one
:- pickup(R,S,T), carry(R,S,T-1), T=1..m.

% Robot can only pickup if it is in the same location as the shelf
:- pickup(R,S,T), shelfLocation(S,X1,Y1,T), robotLocation(R,X2,Y2,T), node(N1,X1,Y1), node(N2,X2,Y2), N1!=N2, T=1..m.

% if the shelf is picked up, then it is being carried
carry(R,S,T) :- pickup(R,S,T), T=1..m.

%%%%%%%%%%% PUTDOWN %%%%%%%%%%%%%%%%
% putdown is exogenous
{putdown(R,S,T):shelf(S)}1 :- robot(R), T=1..m.
occurs(object(robot,R), putdown, T) :- putdown(R,S,T).

% cant be put down by 2 different robots
:- 2{putdown(R,S,T):robot(R)}, shelf(S), T=1..m.

% Can only put down a shelf if it has one
:- putdown(R,S,T), not carry(R,S,T-1), T=1..m. 

% if the shelf is put down, then it is not being carried.
not carry(R,S,T) :- putdown(R,S,T), T=1..m.

%%%%%%%%%%%%%%%% LAWS OF INERTIA %%%%%%%%%%%%%%%%%%%%
{robotLocation(R,X,Y,T)} :- robotLocation(R,X,Y,T-1), T=1..m.
{carry(R,S,T)} :- carry(R,S,T-1), T=1..m.
{shelfLocation(S,X,Y,T)} :- shelfLocation(S,X,Y,T-1), T=1..m.


%%%%%%%%%%%%%%%% AXIOMS %%%%%%%%%%%%%%%%%%%%%%%
% robot can only do one thing at a time
:- occurs(object(robot, R), A1, T), occurs(object(robot, R), A2, T), A1!=A2.
