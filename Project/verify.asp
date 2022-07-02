:- not occurs(object(robot,1), move (-1,0), 1).
:- not occurs(object(robot,2), move (-1,0), 1).
:- not occurs(object(robot,1), move (-1,0), 2).
:- not occurs(object(robot,2), pickup, 2).
:- occurs(object(robot,1), _, 3).
:- not occurs(object(robot,2), move (0,1), 3).
:- not occurs(object(robot,1), pickup, 4).
:- not occurs(object(robot,2), deliver(1,3,4), 4).
:- not occurs(object(robot,1), move (-1,0), 5).
:- not occurs(object(robot,2), move (0,-1), 5).
:- not occurs(object(robot,1), deliver (1,1,1), 6).
:- not occurs(object(robot,2), putdown, 6).
:- not occurs(object(robot,1), putdown, 7).
:- not occurs(object(robot,2), move (1,0), 7).
:- not occurs(object(robot,1), move (1,0), 8).
:- not occurs(object(robot,2), move (1,0), 8).
:- not occurs(object(robot,1), move (0,-1), 9).
:- not occurs(object(robot,2), pickup, 9).
:- not occurs(object(robot,1), pickup, 10).
:- not occurs(object(robot,2), move (0,-1), 10).
:- not occurs(object(robot,1), move (1,0), 11).
:- not occurs(object(robot,2), deliver (3,4,1), 11).
%:- not occurs(object(robot,1), move (0,-1), 12).
%:- not occurs(object(robot,2), move (1,0), 12).
%occurs(object(robot,1), deliver (2,2,1), 13).
