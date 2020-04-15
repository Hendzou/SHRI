:- consult(map).
:- consult(robot_state).
:- dynamic(user_name/1).
:- dynamic(last_item/1).
:- dynamic(last_vrb/1).
:- dynamic(last_frm/1).
:- dynamic(last_to/1).
:- dynamic(expect/1).
:- dynamic(ans/1).
:- dynamic(full/1).
:- dynamic(mounted/1).

last_vrb('none').
last_item('none').
last_frm('none').
last_to('none').
expect('none').

come('none', 'none', 'here') :- go('none', 'none', 'me').

come('none', 'none', 'me') :- go('none', 'none', 'me').

come('none', 'none', 'none') :- go('none', 'none', 'me').
 
go('none', 'none', Y) :- not(full(bat)), write('I cannot move, my battery is too low'), nl, assertz(ans('t')).

go('none', 'none', Y) :- full(bat), Y \== 'me', Y \== 'there', not(est(Y, D)), write('I do not know that location '), nl, assertz(ans('t')).

go('none', 'none', Y) :- full(bat), est(Y, D), not(location(D)), write('I cannot go there, it is not a location '), nl, assertz(ans('t')).

go('none', 'none', 'me') :- full(bat), loc(P), retract(loc(P)), assertz(loc('me')), last_to(C), retract(last_to(C)), assertz(last_to(Y)), write('Here I am '), nl, assertz(ans('t')).

go('none', 'none', 'there') :- full(bat), last_to(D), loc(P), retract(loc(P)), assertz(loc(D)), write('Okay, I am there'), nl, assertz(ans('t')).

go('none', 'none', Y) :- full(bat), est(Y, D), Y \== ('me'), Y \== ('there'), location(D), loc(P), retract(loc(P)), assertz(loc(D)), last_to(C), retract(last_to(C)), assertz(last_to(Y)), write('Okay, I am right next to the '), write(Y), nl, assertz(ans('t')).

take(X, Y, Z) :- not(mounted(man)), write('My manipulator is unmounted, I cannot handle anything'), nl, assertz(ans('t')).

take(X, 'none', 'none') :- not(full(bat)), write('My battery is low, I cannot take anything'), nl, assertz(ans('t')).

take(X, Y, 'none') :- not(full(bat)), Y \== 'none', write('My battery is low, I cannot take anything'), nl, assertz(ans('t')).

take(X, 'none', Z) :- not(full(bat)), Z \== 'none', write('My battery is low, I cannot take anything'), nl, assertz(ans('t')).

take(X, Y, Z) :- Y \== 'none', Z \== 'none', bring(X, Y, Z).

take(X, 'none', 'none') :- full(bat), mounted(man), not(free(man)), located(man, O), est(P, O), last_item(A), retract(last_item(A)), assertz(last_item(O)), write('I cannot take it, my manipulator is holding the '), write(P), nl, assertz(ans('t')).

take(X, Y, 'none') :- full(bat), mounted(man), not(free(man)), X \==('it'), Y \== ('none'), located(man, O), est(P, O), last_item(A), retract(last_item(A)), assertz(last_item(P)), write('I cannot take it, my manipulator is holding the '), write(P), nl, assertz(ans('t')).

take(X, 'none', Z) :- full(bat), mounted(man), not(free(man)), X \== ('it'), Z \== ('none'), located(man, O), est(P, O), last_item(A), retract(last_item(A)), assertz(last_item(P)), write('I cannot take it, my manipulator is holding the '), write(P), nl, assertz(ans('t')).

take(X, 'none', 'none') :- full(bat), mounted(man), free(man), not(est(X, O)), X\== ('it'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('take')), expect(D), retract(expect(D)), assertz(expect('obj')), write('I do not know what that is...can you express it differently?'), nl, assertz(ans('t')).

take(X, 'none', 'none') :- full(bat), mounted(man), free(man), est(X, O), X \== ('it'), not(handable(O)), write('I cannot handle that object, I am sorry'), nl, assertz(ans('t')).

take(X, 'none', 'none') :- full(bat), mounted(man), free(man), X \==('it'), est(X, O), handable(O), not(located(F, O)), write('There is no '), write(X), nl, assertz(ans('t')).

take('it', 'none', 'none') :- last_item(X), take(X, 'none', 'none').

take('it', Y, 'none') :- last_item(X), Y \== 'none', take(X, Y, 'none').

take('it', 'none', Z) :- last_item(X), Z \== 'none', take(X, 'none', Z).

take('it', Y, Z) :- last_item(X), Y \== 'none', Z \== 'none', take(X, Y, Z).

take(X, Y, 'none') :- full(bat), mounted(man), free(man), X \== ('it'), est(X, O), handable(O), Y \=='none', est(Y, F), not(located(F, O)), last_item(A), retract(last_item(A)), assertz(last_item(X)) , write('It is not there'), nl, assertz(ans('t')).

take(X, Y, 'none') :- full(bat), mounted(man), free(man), X \== ('it'), est(X, O), handable(O), Y \== ('none'), est(Y, F), located(F, O), retract(dlocated(F, O)), assertz(dlocated(man, O)), retract(free(man)), last_item(A), retract(last_item(A)), assertz(last_item(X)) , write('Okay, I took it'), nl, assertz(ans('t')).

take(X, 'none', 'none') :- full(bat), mounted(man), free(man), X \== ('it'), est(X, O), handable(O), located(F, O), retract(dlocated(F, O)), assertz(dlocated(man, O)), retract(free(man)), last_item(A), retract(last_item(A)), assertz(last_item(X)) , write('Okay, I took it'), nl, assertz(ans('t')).

take(X, 'none', Z) :- X \== ('it'), Z \== ('none'), Z \== ('tray'), located(F, O), est(Y, F), bring(X, Y, Z).

take(X, 'none', Z) :- X \== ('it'), Z \== ('none'), Z \== ('tray'), mounted(man), not(located(F, O)), write('It is not around here'), nl, assertz(ans('t')).

put(X, Y, Z) :- not(mounted(man)), write('My manipulator is unmounted, I cannot handle anything'), nl, assertz(ans('t')).

put('it', Y, 'tray') :- full(bat), mounted(man), last_item(X), put(X, Y, 'tray'). 

put(X, 'none', 'tray') :- full(bat), mounted(man), not(free(tra)), est(X, C), X \== ('it'), last_item(A), retract(last_item(A)), assertz(last_item(X)), located('tra', O), est(B, O), write('I cannot, because the tray is not empty, there is the '), write(B),  nl.

put(X, 'none', 'tray') :- full(bat), mounted(man), free(tra), est(X, O), X \== ('it'), handable(O), located(man, O), retract(dlocated(man, O)), assertz(dlocated(tra, O)), assertz(free(man)), retract(free(tra)), last_item(A), retract(last_item(A)), assertz(last_item(X)), write('okay, it is on the tray now'), nl.

put(X, Y, 'tray') :- full(bat), mounted(man), not(free(tra)), X \== ('it'), est(X, C), Y \== 'none', est(Y, D), last_item(A), retract(last_item(A)), assertz(last_item(X)), located('tra', O), est(B, O), write('I cannot, because the tray is not empty, there is the '), write(B),  nl.

put(X, Y, 'tray') :- full(bat), mounted(man), free(tra), est(X, O), Y \== 'none', X \== ('it'), handable(O), located(man, O), retract(dlocated(man, O)), assertz(dlocated(tra, O)), assertz(free(man)), retract(free(tra)), last_item(A), retract(last_item(A)), assertz(last_item(X)), write('okay, it is on the tray now'), nl.

put(X, 'none', 'none') :- full(bat), mounted(man), last_vrb(V), last_item(O), X \== ('it'), retract(last_vrb(V)), retract(last_item(O)), assertz(last_vrb('put')), assertz(last_item(X)), expect(D), retract(expect(D)), assertz(expect('to')), write('where do you want me to put it?'), nl, assertz(ans('t')).

put(X, 'none', Z) :- not(full(bat)), X \== ('it'), Z \== ('none'), Z \== ('tray'), write('My battery is too low, I cannot do it'), nl, assertz(ans('t')).

put(X, 'none', Z) :- full(bat), mounted(man), not(est(X, O)), X \== ('it'), Z \== ('none'), Z \== ('tray'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('put')), expect(D), retract(expect(D)), assertz(expect('obj')), last_to(T), retract(last_to(T)), assertz(last_to(Z)), write('I am sorry, I do not know what it is, can you name it differently?'), nl, assertz(ans('t')).

put(X, 'none', Z) :- full(bat), mounted(man), est(X, O), not(located(man, O)), X \== ('it'), Z \== ('tray'), last_item(A), retract(last_item(A)), assertz(last_item(X)), write('but I do not have it'), nl, assertz(ans('t')).

put(X, 'none', Z) :- full(bat), mounted(man), X \== ('it'), est(X, O), located(man, O), Z\==('none'), Z \== ('there'), Z \== ('tray'), not(est(Z, T)), write('I do not understand, where should I put it?'), last_vrb(V), last_item(A), expect(B), retract(last_vrb(V)), retract(last_item(A)), retract(expect(B)), assertz(last_vrb('put')), assertz(last_item(X)), assertz(expect('to')),  nl, assertz(ans('t')).

put(X, 'none', Z) :- full(bat), mounted(man), est(X, O), X \==('it'), located(man, O), est(Z, T), Z \== ('tray'), not(location(T)), write('but it is not a location'), nl, assertz(ans('t')).

put('it', 'none', 'none') :- full(bat), mounted(man), last_item(X), write('you mean the '), write(X), nl, put(X, 'none', 'none').

put('it', 'none', Z) :- full(bat), mounted(man), last_item(X), Z \== ('tray'), put(X, 'none', Z).

put(X, 'none', Z) :- full(bat), mounted(man), X \== ('it'), est(X, O), located(man, O), Z \== ('none'), Z \== ('tray'), est(Z, T), location(T), retract(dlocated(man, O)), assertz(free(man)), assertz(dlocated(T, O)), last_item(A), retract(last_item(A)), assertz(last_item(X)), write('okay, I have put it there'), nl, assertz(ans('t')).

bring(X, Y, Z) :- not(full(bat)), write('My battery is too low to do that'), nl, assertz(ans('t')).

bring(X, Y, Z) :- not(mounted(man)), write('My manipulator is unmounted, I cannot handle anything'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), not(free(man)), located(man, A), est(B, A), last_item(C), retract(last_item(C)), assertz(last_item(B)) , write('My manipulator is holding the '), write(B), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), not(est(X, O)), X  \== ('it'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), last_frm(B), retract(last_frm(B)), last_to(C), retract(last_to(C)), assertz(last_frm(Y)), assertz(last_to(Z)), assertz(expect('obj')), write('I am sorry, there is no such object as that, maybe I can bring you something else?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), X \== ('it'), est(X, O), handable(O), est(Y, F), not(location(F)), Y \== ('none'), Y \== ('there'), Z \== ('none'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_to(C),  retract(last_to(C)), assertz(last_to(Z)), assertz(expect('frm')), write('That is not a loction, from where should I take it?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \== ('it'), est(X, O), handable(O), not(est(Y, F)), Y \== ('there'), Y \== ('none'), Z \== ('none'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_to(C),  retract(last_to(C)), assertz(last_to(Z)), assertz(expect('frm')), write('I do not know that location, from where should I take it?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \== ('it'), est(X, O), handable(O), est(Y, F), location(F), Z \== ('there'), Z \== ('none'), est(Z, T), not(location(T)), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_frm(B), retract(last_frm(B)), last_to(C), retract(last_to(C)), assertz(last_frm(Y)), assertz(expect('to')), write('That is not a loction, to where should I bring it?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \== ('it'), est(X, O), handable(O), est(Y, F), location(F), not(est(Z, T)), Z \== ('there'), Z \==('none'), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_frm(B), retract(last_frm(B)), last_to(C), assertz(last_frm(Y)), assertz(expect('to')), write('There is no such loction as that, to where should I bring it?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \== ('it'), Y \==('none'), Z \== ('none'), est(X, O), handable(O), est(Y, F), est(Z, T), location(F), location(T), not(located(F, O)), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_frm(B), retract(last_frm(B)), assertz(last_frm(Y)), last_to(C), retract(last_to(C)), assertz(last_to(Z)), assertz(expect('frm')), write('it is not there, where can I find it?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \==('it'), Y \==('none'), Z \== ('none'), est(X, O), not(handable(O)), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_frm(B), retract(last_frm(B)), assertz(last_frm(Y)), last_to(C), retract(last_to(C)), assertz(last_to(Z)), assertz(expect('obj')), write('I m sorry, this is not an object I can handle, what should I bring instead?'), nl, assertz(ans('t')).

bring(X, Y, Z) :- full(bat), mounted(man), free(man), free(tra), X \== ('it'), est(X, O), handable(O), Y \== ('none'), Z \==('none'), est(Y, F), est(Z, T), location(F), location(T), located(F, O), retract(dlocated(F, O)), last_vrb(V), retract(last_vrb(V)), assertz(last_vrb('bring')), last_item(A), retract(last_item(A)), assertz(last_item(X)), last_frm(B), retract(last_frm(B)), assertz(last_frm(Y)), last_to(C), retract(last_to(C)), assertz(last_to(Z)), assertz(dlocated(T, O)), write('Just a second...Alright, it s done'), nl, assertz(ans('t')).

bring('it', Y, Z) :- Y \== ('there'), write('you are referring to the '), last_item(X), write(X), nl, bring(X, Y, Z).

bring(X, Y, 'none') :- X \== ('it'), Y \== ('none'), bring(X, Y, 'me').

bring(X, 'none', 'none') :- X \==('it'), bring(X, 'none', 'me').

bring(X, 'there', Z) :- X \== ('it'), write('you mean from the '), last_to(Y), write(Y), nl, bring(X, Y, Z).

bring('it', 'there', Z) :- last_item(X), last_to(Y), write('you mean the '), write(X), write(' from the '), write(Y), nl, bring(X, Y, Z).

give(X, Y, 'me') :- put(X, Y, 'hand_user').

none(X, Y, Z) :- expect('obj'), last_vrb('take'), take(X, Y, Z).

none(X, Y, Z) :- expect('obj'), last_vrb('bring'), last_frm('F'), last_to('T'), bring(X, F, T).

none(X, Y, Z) :- expect('obj'), last_vrb('put'), last_to('T'), put(X, Y, T).

none(X, Y, Z) :- expect('frm'), last_vrb('take'), last_item(O), last_to(T), take(O, Y, T).

none(X, Y, Z) :- expect('frm'), last_vrb('bring'), last_item(O), last_to(T), bring(O, Y, T).

none(X, Y, Z) :- expect('to'), last_vrb('go'), go(X, Y, Z).

none(X, Y, Z) :- expect('to'), last_vrb('come'), come(X, Y, Z).

none(X, Y, Z) :- expect('to'), last_vrb('take').

none(X, Y, Z) :- expect('to'), last_vrb('put'), last_item(A), put(A, Y, Z).

none(X, Y, Z) :- expect('to'), last_vrb('bring'), last_item(A), last_frm(F), put(A, F, Z).

recharge('battery', Y, Z) :- assertz(full(bat)), write('My battery is fully charged, I feel good!'), nl, assertz(ans('t')).

recharge('your_battery', Y, Z) :- recharge('battery', Y, Z).

check('t') :- not(ans('t')), write('I am confused, express it differently please?'), nl.
