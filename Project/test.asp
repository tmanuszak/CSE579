init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(1,2))).
init(object(node,3),value(at,pair(1,3))).
init(object(node,4),value(at,pair(2,2))).
init(object(robot,1),value(at,pair(1,1))).
init(object(robot,2),value(at,pair(1,2))).
init(object(shelf,1),value(at,pair(1,3))).
init(object(shelf,2),value(at,pair(1,2))).
%init(object(highway,1),value(at,pair(1,2))).

:- not robotLocation(1,1,1,m).
:- not shelfLocation(1,1,1,m).
:- not carry(1,1,m).

#show occurs/3.
#show carry/3.
#show putdown/3.
#show pickup/3.
#show shelfLocation/4.
#show robotLocation/4.
