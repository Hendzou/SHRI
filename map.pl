est(cup, X) :- est(mug, X).

est(bottle_water, X) :- est(water_bottle, X).
est(bottle_juice, X) :- est(juice_bottle, X).
est(bottle, X) :- est(bottle_water, X).
est(bottle, X) :- est(bottle_juice, X).
est(bottle, X) :- est(water_bottle, X).
est(bottle, X) :- est(juice_bottle, X).

est(can, X) :- est(coke_can, X).

est(drink, X) :- est(bottle, X).
est(drink, X) :- est(can, X).

est(apple, X) :- est(apple, X).

est(fruit, X) :- est(banana, X).
est(fruit, X) :- est(apple, X).

est(snack, X) :- est(fruit, X).

est(object, X) :- est(drink, X).
est(object, X) :- est(snack, X).
est(object, X) :- est(plate, X).
est(object, X) :- est(cup, X).

est(here, X) :- est(hand_user, X).
est(me, X) :- est(hand_user, X).

handable(X) :- est(water_bottle, X).
handable(X) :- est(juice_bottle, X).
handable(X) :- est(coke_can, X).
handable(X) :- est(banana, X).
handable(X) :- est(apple, X).
handable(X) :- est(plate, X).
handable(X) :- est(cup, X).

location(X) :- est(manipulator, X).
location(X) :- est(tray, X).
location(X) :- est(table, X).
location(X) :- est(fridge, X).
location(X) :- est(hand_user, X).
location('me').
location('there').
location('here').

identical(X, Y) :- bottle_water(X), bottle_water(Y), X\=Y.
identical(X, Y) :- bottle_juice(X), bottle_juice(Y), X\=Y.

