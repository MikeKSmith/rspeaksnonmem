$PROBLEM PK ODE HANDS ON ONE
$INPUT ID TIME DV AMT CMT FLAG MDV EVID SDE QA=XVID1 QB=XVID2 QZ=XVID3
$DATA   sde8.csv IGNORE=@
$SUBROUTINE ADVAN6 TOL 10 DP
$MODEL 
COMP = (CENTRAL);
COMP = (P1)
$THETA (0, 10, ) ; 1 CL
(0, 32, ) ; 2 VD
(0, 2, ) ; 4 SIGMA
(0, 1, ) ; SGW1
$OMEGA 0.1  ; 1 CL
$OMEGA 0.01  ; 2 VD
$SIGMA 1 FIX ; PK
$PK
IF(NEWIND.NE.2) OT = 0
TVCL  = THETA(1)
CL    = TVCL*EXP(ETA(1))
TVVD  = THETA(2)
VD    = TVVD*EXP(ETA(2))
SGW1 = THETA(4)
IF(NEWIND.NE.2) THEN
AHT1 = 0
PHT1 = 0
ENDIF
IF(EVID.NE.3) THEN
A1 = A(1)
A2 = A(2)
ELSE
A1 = A1
A2 = A2
ENDIF
IF(EVID.EQ.0) OBS = DV
IF(EVID.GT.2.AND.SDE.EQ.2) THEN
RVAR = A2*(1/VD)**2+ THETA(3)**2
K1   = A2*(1/VD)/RVAR
AHT1 = A1 + K1*(OBS -( A1/VD))
PHT1 = A2 - K1*RVAR*K1
ENDIF
IF(EVID.GT.2.AND.SDE.EQ.3) THEN
AHT1 = A1
PHT1 = 0
ENDIF
IF(EVID.GT.2.AND.SDE.EQ.4) THEN
AHT1 = 0
PHT1 = A2
ENDIF
IF(A_0FLG.EQ.1) THEN
A_0(1) = AHT1
A_0(2) = PHT1
ENDIF
$DES
DADT(1) = - CL/VD*A(1) ;+0
DADT(2) = (-CL/VD)*(A(2))+(-CL/VD)*(A(2))+SGW1*SGW1
$ERROR (OBS ONLY)
IPRED = A(1)/VD
IRES  = DV - IPRED
W=SQRT(A(2)*(1/VD)**2+ THETA(3)**2)
IWRES = IRES/W
Y     = IPRED+W*EPS(1)
$EST MAXEVAL=9999 METHOD=1 LAPLACE NUMERICAL SLOW INTER NOABORT SIGDIGITS=3 PRINT=1 MSFO=sde8.msf
$COV MATRIX=R 

$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES EVID APPEND ONEHEADER NOPRINT FILE=sde8.fit
