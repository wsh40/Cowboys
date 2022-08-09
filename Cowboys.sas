* This program is called Cowboys.SAS;

* First, clean the log and results windows;
ODS HTML CLOSE ;
ODS HTML ;
DM 'LOG; CLEAR; ODSRESULTS; CLEAR' ;

* Insert your name below;
TITLE ' Will Hallgren ';

* Read the data file from the E drive;
PROC IMPORT DATAFILE = ' E:/AE/Data/Cowboys1.CSV ' 
  OUT = Cowboys
  DBMS = CSV
  REPLACE ;
  GETNAMES = YES ;
  RUN ;
/*
* Dummy rule for home_dum;
PROC MEANS MAXDEC=0 MIN MAX DATA = Cowboys;
  CLASS home_dum;
  VAR game_won;
  RUN;

  * Dummy rule for halftime_dum;
PROC MEANS MAXDEC=0 MIN MAX DATA = Cowboys;
  CLASS halftime_dum;
  VAR game_won;
  RUN;
*/
* 5 basic summary statistics for all variables in the data set, to zero decimal places;
PROC MEANS MAXDEC=2;
  RUN;

* 5 basic summary statistics just for games won and games lost;
PROC MEANS MAXDEC=2;
  CLASS game_won;
  RUN;

  * Next, generate the 5 basic summary statistics just for home games and away games;
PROC MEANS MAXDEC=2;
  CLASS home_dum;
  RUN;

  *1 Next, estimate, by probit using PROC QLIM, the regression of Y on all regressors;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
win_percent_season 
p_scored
p_allowed
home_dum
q_rate_cowboys
q_rate_op
yards_pass
yards_pass_op
yards_rush
yards_rush_op
num_penalty
loss_penalty
num_fumble
loss_fumble
num_sack
loss_sack
field_goal
halftime_dum
attendance_capacity
percent_total_possession

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
/* *2;
  PROC QLIM DATA=Cowboys;
	MODEL game_won = 
win_percent_season 
home_dum
q_rate_cowboys
q_rate_opp
yards_pass
yards_rush
num_sack
halftime_dum
attendance_capacity
percent_total_possession

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*3;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
win_percent_season 
home_dum
q_rate_cowboys
q_rate_opp
yards_pass
yards_pass_op
yards_rush
yards_rush_op
num_penalty
loss_penalty
num_sack
loss_sack
field_goal
halftime_dum
attendance_capacity

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*4;
  PROC QLIM DATA=Cowboys;
	MODEL game_won = 
win_percent_season
home_dum
q_rate_cowboys
q_rate_opp
yards_pass
yards_pass_op
yards_rush
yards_rush_op
num_penalty
loss_penalty
num_sack
loss_sack
field_goal
halftime_dum
/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
  *5;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
p_scored
p_allowed
q_rate_cowboys
q_rate_op
yards_rush_op
num_penalty

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN; 
  *6;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
p_scored
p_allowed
home_dum
q_rate_cowboys
q_rate_op
yards_rush_op
num_penalty
halftime_dum
Attendance_capacity
covid_dum
attendance_capacity*covid_dum

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
  *7;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
p_scored
p_allowed
q_rate_cowboys
q_rate_op
yards_pass
yards_rush_op
num_penalty
Attendance_capacity

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
  *8;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
p_scored
p_allowed
home_dum
q_rate_cowboys
q_rate_op
num_penalty
halftime_dum
Attendance_capacity

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
  *9;
  PROC QLIM DATA=Cowboys;
	MODEL game_won =  
p_scored
p_allowed
home_dum
q_rate_cowboys
q_rate_op
yards_pass
yards_pass_op
yards_rush
num_penalty
loss_sack
attendance_capacity

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*/	


  /* *10 ALL SIGNIFICANT BUT ONE;
PROC QLIM DATA=Cowboys;
	MODEL game_won = 
win_percent_season 
p_scored
p_allowed
num_penalty
loss_penalty
num_fumble
num_sack
field_goal
halftime_dum
percent_total_possession

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*11;
PROC QLIM DATA=Cowboys;
	MODEL game_won =  
p_scored
p_allowed
yards_pass
yards_rush
num_penalty
num_sack
field_goal

/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*12;
PROC QLIM DATA=Cowboys;
	MODEL game_won =
win_percent_season 
num_penalty
loss_penalty
num_fumble
num_sack
field_goal
halftime_dum
percent_total_possession

	/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*13;
PROC QLIM DATA=Cowboys;
	MODEL game_won =
win_percent_season
q_rate_cowboys
yards_rush_op 
num_penalty
num_fumble
num_sack
field_goal
halftime_dum
percent_total_possession

	/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;
*/ *14;
PROC QLIM DATA=Cowboys;
	MODEL game_won =
win_percent_season
q_rate_cowboys
q_rate_op
yards_rush
yards_rush_op 
num_penalty
field_goal
halftime_dum

	/ DISCRETE;
 OUTPUT OUT=PROB_RESULTS MARGINAL PROBALL;
  RUN;

 
  * Next, print the value of Y and the estimated marginal effects;
PROC PRINT;
  VAR game_won 
Meff_p2_win_percent_season
Meff_p2_q_rate_cowboys
Meff_p2_q_rate_op
Meff_p2_yards_rush
Meff_p2_yards_rush_op 
Meff_p2_num_penalty
Meff_p2_field_goal
Meff_p2_halftime_dum ;
  RUN;

  * Finally, print the actual value of Y and the predicted probability of observing Y=1;
PROC PRINT;
  VAR game_won PROB2_game_won;
  RUN;

  * Always end with a QUIT statement to close off the DM call at the beginning of the program. ;
QUIT;
