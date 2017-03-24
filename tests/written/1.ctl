$PROB 1 phase1 2 CMT like 1004 but diff. initial on V3
$INPUT C ID TIME SEQ=DROP EVID AMT DV SUBJ HOUR HEIGHT WT SEX AGE DOSE FED
$DATA   ../../data/derived/phase1.csv IGNORE=C
$SUBROUTINE ADVAN4 TRANS4
$PK
CL=THETA(1)*EXP(ETA(1)) * THETA(6)**SEX * (WT/70)**THETA(7)
V2 =THETA(2)*EXP(ETA(2))
KA=THETA(3)*EXP(ETA(3))
Q  =THETA(4)
V3=THETA(5)
S2=V2
$ERROR
Y=F*(1+ERR(1)) + ERR(2)
IPRE=F
$THETA 7.565
19.23
0.0667
3.882
107.5
1.102
1.34
$OMEGA 0.1847   
0.1540   
0.1363  
$SIGMA 0.06894  
$SIMULATION (7996 NEW) (8997 UNIFORM)  ONLYSIMULATION 
$TABLE ID TIME DV WT SEX LDOS NOAPPEND ONEHEADER NOPRINT FILE=sim.tab
