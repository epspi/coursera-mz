% assignment 2
% select a set of raiding warrior
enum WARRIOR;
WARRIOR: dummy; 
enum CLAN; % the clan they belong too

int: l; % minimum raid party size
int: u; % maximum raid party size
int: m; % limit of hatreds

array[WARRIOR] of int: strength;
array[WARRIOR] of CLAN: clan;
var set of WARRIOR: raid; 

array[CLAN,CLAN] of 0..1: hates;

% raid size constraint
constraint card(raid) >= l /\ card(raid) <= u;

% no dummy warriors
constraint not(dummy in raid);

% take the strongest of each clan
constraint forall(w in raid)(strength[w] >= 
    max( [strength[i] | i in WARRIOR where clan[i] = clan[w] /\ not(i in raid)]));

% Hatred constraint
constraint sum(i,j in raid where i < j)(hates[clan[i], clan[j]]) <= m;

% Maximize strength
var int: obj;
constraint obj = sum(i in raid)(strength[i]);
solve maximize obj;

% output [
%     "strength = ", show(total_strength), "\n",
%     "raid     = ", show(raid diff {dummy})
% ];