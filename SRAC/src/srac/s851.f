C             S851                LEVEL=1        DATE=80.09.29
      SUBROUTINE S851
C   *** TEST OUTER ITERATION CONVERGENCE, COMPUTE NEW EIGENVALUE FOR
C       SEARCH
      COMMON /SN1C/
     &              D(1),LIM1,LR,LW,LDSN,LMA,LMZ,LMB,LMC,LXMD,LFIX,LFLT,
     &       LJ5,LRM,LDF,LJ3,LJ4,LIGT,LART,LALFT,
     &LFGP,LFGG,LEND,LV,LAA,LWD,LMR,LPNC,
     &ID,ITH,ISCT,ISN,IGE,IBL,IBR,IZM,IM,IEVT,IGM,IHT,IHS,IHM,MS,MCR,MTP
     &,MT,IDFM,IPVT,IQM,IPM,IPP,IIM,ID1,ID2,ID3,ID4,ICM,IDAT1,IDAT2,IFG,
     &IFLU,IFN,IPRT,IXTR,
     &EV,EVM,EPS,BF,DY,DZ,DFM1,XNF,PV,RYF,XLAL,XLAH,EQL,XNPM,
     &T(12),NIN,NOU,NT1,NT2,NT3,NT4,NT5,NT6,NT7
      COMMON /WORK/ Z(1),LIM2,LXKI,LFD,LXN,LVE,LMTT,LCRX,LQ,LPA,
     &       LXJ,LCH,LCA,LCF,LCT,LCS,LTAB,
     &LXND,LSA,LSAT,LRAV,LRA,LXNN,LXNE,LXNR,LXNA,LSR,LST,LQG,LFG,LSG,
     &LXKE,LXNI,LXNO,LT3,LT5,LDA,LDB,LDC,LDS,LB,IGMP,IGMM,IIGG,NERR,IMJT
     &,IHG,IMP,MP,NDS,NUS,SDG,SCG,AG,XNLGG,XNLG,SNG,ALA,ASR,EAM,EPG,EQ,
     &E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19
     &,E20,ESC,ESM,EVP,EVPP,FTP,IC,ICVT,IGP,IG,IHP,IIC,IIG,IP,IZP,I01,
     &I02,I03,I04,I05,I06,I07,I08,I09,I00,JT,LC,MG,MI,ML,MM,NFN,XITR,
     &XLAP,XLAPP,XLAR,XLA,XNIO,XNII,ZZ1,NZ2,ZZ3,XNB,XKEP,XKIP,IH,I,K,L,
     &M,J,N,NN,ISV
      COMMON /MAINC/ III(1000)
      EQUIVALENCE (III(64),NOUT1)
CKSK  CALL ITIME(I)
      CALL IATIME(I)
      IF((I-NT5)/60  .LT. NZ2  .OR.  NZ2.LE.0) GO TO 851
      IF(ICVT.EQ.0)GO TO 21
      WRITE (NOUT1,20)
   20 FORMAT('0  EXECUTION TIME EXCEEDED - ANISN WILL FORCE THIS ',
     &'PROBLEM TO ENTER THE TERMINATION PHASE')
      GO TO 21
  851 E1=1.0 - XLA
      E2=ABS(E1)
      E3=RYF*ABS(1.0 - ALA)
      E5=ABS(1.0 - E15)*RYF
      IF(NUS.EQ.0)E5=0.0
      E5=AMAX1(E2,E3,E5)
      E2=AMAX1(E2,E3)
      IF(IEVT-1)1,2,3
    2 EV=XKIP/XKEP
C   *** TEST CONVERGENCE WHEN IEVT.LE.1
    1 IF(E5.GT.EPS)GO TO 5
      IF(ICVT.EQ.1)GO TO 15
      ICVT=1
      GO TO 7
    5 ICVT=0
    7 I09=1
      GO TO 999
C   *** TEST CONVERGENCE WHEN IEVT.GT.1
    3 IF(IC.NE.1)GO TO 19
      ICNT=0
      ITRIG=0
   19 IF(ITRIG.EQ.1)GO TO 4
      IF(IEVT.EQ.2)GO TO 17
      E4=ABS(XLA-XLAR)
      IF(E4.GT.EQL .OR. E3.GT.EQL)GO TO 5
      IF(XLAPP.EQ.0.0)GO TO 6
      IF(E2.LE.EQL)GO TO 9
      A=XLAPP-XLA
      B=EVPP-EV
      EQA=(B*(XLAPP-XLAP) - A*(EVPP-EVP))/(B*(EVPP-EVP)*(EVP-EV))
      EQB=A/B - EQA*(EV+EVPP)
      EQC=XLA - EV*(EQA*EV + EQB) - 1.0
      A=EQB*EQB - 4.0*EQA*EQC
      IF(A.LT.0.0)GO TO 8
      EQ=1.0/(2.0*EQA*EV + EQB)
      EV1=( SQRT(A)-EQB)/(2.0*EQA)
      EV2=(-SQRT(A)-EQB)/(2.0*EQA)
      IF(ABS(EV1-EV) .GT. ABS(EV2-EV))EV1=EV2
      GO TO 10
    9 ITRIG=1
      GO TO 16
   17 IF(IC.LE.3)GO TO 18
      EQ=(EV-EVP)/(XLA-XLAP)
      IF(E2.LE.EQL)GO TO 9
   18 EV1=(XNF*(XLA-1.0) + E6*EV)/E6
      IF(IC.LE.3)EV1=0.5*(EV + EV1)
      GO TO 10
    6 IF(XLAP.EQ.0.0)GO TO 11
    8 EQ=(EV-EVP)/(XLA-XLAP)
   16 EV1=EV + E1*EQ*XNPM
      GO TO 10
   11 EV1=EV + EVM
      IF(E1.GT.0.0)EV1=EV - EVM
   10 XLAPP=XLAP
      XLAP=XLA
      EVPP=EVP
   12 EVP=EV
      EV=EV1
      IF((XLAP-1.0)/(XLAPP-1.0) .LT. 0.0 .AND.   IC.GE.3)EV=0.5*(EV+EVP)
      I09=3
      IF(IEVT.EQ.2)I09=1
      GO TO 999
    4 IF(E5.GT.EPS)GO TO 13
      IF(ICNT.EQ.0)GO TO 14
   21 IF(ICVT.EQ.1)GO TO 15
      ICVT=1
      GO TO 7
   14 ICNT=1
      GO TO 16
   13 ICNT=0
      ICVT=0
      GO TO 16
   15 I09=2
  999 RETURN
      END
