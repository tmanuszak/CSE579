init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(1,2))).
init(object(robot,1),value(at,pair(1,1))).
init(object(robot,2),value(at,pair(1,2))).
init(object(node,3),value(at,pair(2,1))).
init(object(node,4),value(at,pair(2,2))).


:- not robotLocation(1,1,2,m;2,1,1,m).

#show occurs/3.
% #show robotLocation/4.
