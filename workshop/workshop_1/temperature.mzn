array[int] of int: readings;
int: start;
int: n = length(readings);
set of int: HOUR = 1..n;
set of int: HOUR0 = 0..n;

array[HOUR] of float: building_temp = mean(;


enum CHOICE = {heat, strongly_heat, cool, strongly_cool, do_nothing};

