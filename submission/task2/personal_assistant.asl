// personal assistant agent 

/* Task 2 Start of your solution */

best_option(vibrating) :- option(0) .
best_option(natural) :- option(1).
best_option(artificial) :- option(2).
option(0).

@update_option
+!update_option : true <-
    ?option(Old);
    New = ( Old + 1 ) mod 3;
    -option(Old);
    +option(New).

@run_option_vibrating
+!fetch_new_option : best_option(vibrating) <-
    .print("setting mattress vibration");
    setVibrationsMode;
    !update_option.

@run_option_natural
+!fetch_new_option : best_option(natural) <-
    .print("setting blinds");
    raiseBlinds;
    !update_option.

@run_option_artificial
+!fetch_new_option : best_option(artificial) <-
    .print("setting artificial light");
    turnOnLights;
    !update_option.

@react_to_upcoming_event_now
+upcoming_event("now"): owner_state("awake") <-
    .print("enjoy the event");
    -upcoming_event("now").

@react_to_upcoming_event_now_still_sleeping
+upcoming_event("now"): owner_state("asleep") <-
    .print("starting wake-up routine");
    !wake_up.
    

@keep_waking_up_when_event_is_upcoming
+!wake_up : owner_state("asleep") & upcoming_event("now") <-
    .print("fetching new option");
    !fetch_new_option;
    !wake_up.

+!wake_up : true <-
    .print("successfully completed wake-up routine").

@mattress_plan
+mattress(State) : true <-
    .print("mattress is ", State).

@lights_plan
+lights(State) : true <-
    .print("lights are ", State).

@blinds_plan
+blinds(State) : true <-
    .print("blinds are ", State).

@owner_state_plan
+owner_state(State) : true <-
    .print("owner is ", State).

/* Task 2 End of your solution */

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }