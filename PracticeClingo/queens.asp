% Each row has exactly one queen
1 {queen(R,1..n)} 1 :- R=1..n.

% No two queens are on the same column
:- queen(R1,C), queen(R2,C), R1!=R2.

% No two queens are on the same diagonal
:- queen(R1,C1), queen(R2,C2), R1!=R2, |R1-R2|=|C1-C2|.
