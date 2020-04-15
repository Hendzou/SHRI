:- dynamic dis/2.
:- dynamic dlocated/2.
:- dynamic full/1.
:- dynamic free/1.
:- dynamic loc/1.
:- dynamic ans/1.

est(A, B) :- dis(A, B).
dis(water_bottle, a1).
dis(juice_bottle, a2).
dis(banana, a3).
dis(coke_can, a4).
dis(apple, a5).
dis(cup, a6).
dis(plate, a7).
dis(fridge, b1).
dis(table, b2).
dis(hand_user, b4).
dis(manipulator, man).
dis(tray, tra).
dis(battery, bat).

located(A, B) :- dlocated(A, B).
dlocated(b1, a1).
dlocated(b1, a2).
dlocated(b1, a3).

loc(b2).

mounted(man).

free(man).
free(man) :- not(located(man, X)).
free(tra).

ans(t).

full(bat).
