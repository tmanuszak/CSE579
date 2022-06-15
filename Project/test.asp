move(1,0). move(-1,0). move(0,1). move(0,-1).
occurs(object(robot,1),move(DX,DY)),at(object(robot,1),pair(DX,DY)) :- move(DX,DY).
#show at/2.
