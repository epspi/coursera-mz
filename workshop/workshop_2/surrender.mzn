% workshop 2
% select a set of trade negotiation party
enum NEGOTIATOR;
NEGOTIATOR: dummy; 

int: l; % minimum party size
int: u; % maximum party size
int: m; % minimum joint ability

array[NEGOTIATOR] of int: honor;
array[NEGOTIATOR,NEGOTIATOR] of int: joint;

var set of NEGOTIATOR: party;
var int:obj;

% Objective
constraint obj = min(i in party)(honor[i]);

% Party size
constraint card(party) >= l /\ card(party) <= u;

% No dummies here
constraint not(dummy in party);

% Total strength
constraint sum(i,j in party where i < j)(joint[i, j]) >= m;

solve maximize obj;
