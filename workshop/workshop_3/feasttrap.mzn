% Beauty Trap
% Create the most magnificient feast 

include "alldifferent.mzn";

enum DISH;
enum TASTE = {spicy, sour, salty, sweet, umame, bland};
enum TEMP = {hot, cold, warm};
%int: ndish;
%set of int: DISH = 1..ndish;
%set of int: TASTE = 1..6;
%int: spicy = 1; int: sour = 2; int: salty = 3; int: sweet = 4; int: umame = 5; int: bland = 6;
%set of int: TEMP = 1..3;
%int: hot = 1; int: cold = 2; int: warm = 3;


array[DISH] of TASTE: taste;
array[DISH] of TEMP: temp;
array[DISH] of bool: heavy;
array[DISH] of int: value;

int: len; % length of banquet
set of int: COURSE = 1..len;

array[COURSE] of var DISH: dish; % Decision Variables
var int: changes = sum(c in 1..len-1)(
    (taste[dish[c]] != taste[dish[c+1]]) +
    (temp[dish[c]]  != temp[dish[c+1]])  +
    (heavy[dish[c]] != heavy[dish[c+1]])
);

var int: obj;                    % Objective
constraint obj = sum(d in dish)(value[d]) + changes;

% She can only serve each dish once, obviously.
constraint alldifferent(dish);

% She should not serve two dishes of the same taste in a row.
constraint forall(c in 1..len-1)(taste[dish[c]] != taste[dish[c+1]]);

% The first dish should be salty, and the last dish should be sweet.
constraint taste[dish[1]]   = salty;
constraint taste[dish[len]] = sweet;

% After a spicy dish the next dish must be bland or sweet. 
constraint forall(c in 1..len-1)
    (taste[dish[c]] = spicy -> taste[dish[c+1]] in {sweet, bland});

% After a sour dish the next dish must be bland or umami.
constraint forall(c in 1..len-1)
    (taste[dish[c]] = sour -> taste[dish[c+1]] in {umame, bland});

% No spicy or umami dishes directly after a sweet dish.
constraint forall(c in 1..len-1)
    (taste[dish[c]] = sweet -> taste[dish[c+1]] in TASTE diff {umame, spicy});

% Between serving a hot dish and a later cold dish there must be a warm dish.
constraint forall(c in 2..len-1)
    (temp[dish[c-1]] = hot /\ temp[dish[c+1]] = cold -> temp[dish[c]] = warm);

% Diao Chan’s banquet cannot have more than 2 heavy dishes in a row.
constraint forall(c in 1..(len-2))
    (heavy[dish[c]] /\ heavy[dish[c+1]] -> not heavy[dish[c+2]]);

solve maximize obj;
include "data/feasttrap_0.dzn"