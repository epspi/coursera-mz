% common.mzn

% between
predicate between(var int:x, int:lower, int:upper) =
    x <= upper /\ x >= lower;
