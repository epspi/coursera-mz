% workshop 2

include "common.mzn";

% select a set of trade negotiation party
enum NEGOTIATOR;
NEGOTIATOR: dummy; 

int: l; % minimum party size
int: u; % maximum party size
int: m; % minimum joint ability

array[NEGOTIATOR] of int: honor;
array[NEGOTIATOR,NEGOTIATOR] of int: joint;

var set of NEGOTIATOR: party;
var int: obj;

constraint obj = min(i in party)(honor[i]); % Objective
constraint between(card(party), l, u);      % Party size
constraint not(dummy in party);             % No dummies here

% Total strength
constraint sum(i,j in party where i < j)(joint[i, j]) >= m;

solve maximize obj;
