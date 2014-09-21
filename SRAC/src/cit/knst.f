CKNST --117 ***CITATION*** EQ. CONSTANTS FOR 3-D/ CF-EIGN
C
      SUBROUTINE KNST(NRGNE, SCAC,DCONBE,DCONRE, DCONBK,F1,SIG,PTSAE,
     & NCOMP,PVOL,BBND,BND, IVX,JVX,KBVX,KVX,LVX, MVX,IVXP1,JVXP1,
     & KBVXP1,IVZ,KVZ, JIVX,JIP1VX,JP1IXZ,IOVX,IOVZ,A, MEMORY,AIO,
     & IX3738)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      REAL*8 TPTSA,D1,D2,D3,D4,D5,D6,D7,D8,D9
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
      COMMON/AMESH/BMESH(30),NREGI,NREGJ,NREGKB,XSHI(RGX),XSHJ(RGX),
     & XSHKB(RGX), MSHI(RGX),MSHJ(RGX),MSHKB(RGX),Y(MSX),YY(MSX), X(MSX)
     &  ,XX(MSX),Z(MSX),ZZ(MSX), ZONVOL(ZNEX),AVZPD(ZNEX),PDI(MSX),
     & PDJ(MSX) , PDK(MSX)
      COMMON/AFLUX/BFLUX(30),KXMN8,NIT,NIIT,NIIIT,JXP1,KSCT1,KSCT2,
     & ISTART,IEP, VRGP1,VRGP2,VRGP3,VRG1,VRG2,VRGK1,VRGK2,XABS,PROD,
     & XLEK,RMX,RMN,XKEF1,XKEF2,XKEF3,EXFC1,EXFC2,EXFC3, NI3,IEXTR,
     & IRECV,VRGABS,LO3,LO4,XLAMDA,EPI1,EPI2, BETTA,SUMXI,IX25,IX28,I,J,
     &  KB,K,ITMAX,ITIME, BET(MSX),DEL(MSX)
      COMMON/ABURN/BBURN(30),NSIG1(50),NSIG2(50),NSIG3(50),N1N2R(2,ZDX),
     &  NSIG4(50),NSIG5(50),NSIG6(50),NJM(50),NJMM(50),NJNQ(50),NCH(50),
     &  NZON(ZDX),NXSET(ZDX),NXODR(ZDX),IDXSET(ZDX),NCLASS(ZDX),NDP(ZDX)
     &  , XNAME(3,ZDX)
C
      DIMENSION NRGNE(JVX,IVX,KBVX), SCAC(KVX,MVX,KVX),DCONBE(JIP1VX ,
     & KBVX,IOVX),DCONRE(JP1IXZ , KBVX, IOVZ),DCONBK(JIVX ,KBVXP1,IOVX),
     &  F1(KVX ,MVX),SIG(KVX, MVX,12), PTSAE(JIVX ,KBVX,IOVX)
      DIMENSION NCOMP(LVX),PVOL(LVX)
      DIMENSION BBND(KVX),BND(6,KVX)
      DIMENSION A(MEMORY)
      DIMENSION AIO(IX3738)
C
CCCCC ********* SUBSCRIPT DEFINITIONS (KNST E-010) ********* CCCCC
C    NEW         OLD            NEW         OLD
C     N1         J,I             N5 *       J,I+1
C     N2         J,I+1           N6         J,I
C     N3 *       J,I             N7         M,L
C     N4 *     J+1,I             N8         I,J
C     N9 *       1,I             N10 *  JVX+1,I
C     N11 *  JVXP1,IVXP1-I       N12 *  JVXP1,I
C     N14        J,IVXP1         N15 *      1,I
C     N2       J-1,I+1 FOR TRIANGULAR ONLY
C
C  THE * ABOVE REFERS TO INDEXING IN ARRAYS LARGER THAN JVX X IVX
C
C     INRB = 1  ORDINARY
C     INRB = 2  PERIODIC(REPEATING)
C     INRB = 3  90 DEGREE ROTATIONAL
C     INRB = 4  180 DEGREE ROTATIONAL
C
      KKK=0
      INRB=IX(72)+1
      KMAXP1 = KMAX + 1
      IX72 = IX(72)
      IX37 = IX(37)
      IX38 = IX(38)
      IO15 = IX(82)
      IOADJ = IO15
      IF (IX(71).GT.0) IOADJ = IO2
      IF (IX37.GT.0) REWIND IOADJ
      IF (IX(71).GT.0) IX(5) = IX(17)
      IO14 = IX(81)
      REWIND IO14
      GO TO (107,107,102,100),INRB
  100 I=IVX/2
      DO 101J=1,I
      K=IVX+1-J
      TAL=(YY(J)-Y(J))/(Y(K)-YY(K+1))
      IF (NUAC(5).EQ.14) TAL=(PDI(I)-YY(I))/(YY(K+1)-Y(K))
      EPICH = ABS(TAL-1.0)
      IF (EPICH.GT.1.0E-4) GO TO 103
  101 CONTINUE
      GO TO 107
  102 CONTINUE
      IDA = IVX
      IF (NUAC(5).EQ.14) IDA = 2*IVX
      IF (JVX.EQ.IDA) GO TO 104
  103 CONTINUE
      JB = 32
      WRITE(IOUT,1000)JB,I,J
      WRITE(IOUT,2000)
      STOP
  104 CONTINUE
      J = 1
      DO 106 I = 1,IVX
      TAL = Y(I)/X(I)
      IF ((NUAC(5).NE.14).OR.(I.EQ.1)) GO TO 105
      J = J+2
      TAL = (Y(I)-PDI(I-1))/(X(J)-X(J-1))
  105 CONTINUE
      EPICH = ABS(TAL-1.0)
      IF (EPICH.GT.1.0E-4) GO TO 103
  106 CONTINUE
  107 CONTINUE
      EPICH=1.0E-5
      SPARE(51) = -1.0E+30
      SPARE(57) = -1.0E+30
      N17 = NUAC(17)
      SQUIRE=1.1547005
      IF (N17) 114,114,108
  108 IF (XMIS(2)) 114,109,109
  109 DO 113 K = 1,KMAX
      IF (XMIS(2)) 113,110,111
  110 T1 = 0.4692
      GO TO 112
  111 T1 = XMIS(2)
  112 BBND(K) = T1
  113 CONTINUE
  114 CONTINUE
      NDIM = IX(25)
      NGEM = IX(26)
      PI = 3.141593
      IF (IX37.GT.0) GO TO 116
C**** ZERO DCONBE,DCONRE,DCONBK,PTSAE IF NO I/O
      NL = IX(169)
      NU = IX(170)
      DO 115 NIO=NL,NU
      A(NIO) = 0.0
  115 CONTINUE
C****
  116 CONTINUE
      SPARE(98) = 0.0
  117 DO 129 K = 1,KMAX
      READ(IO14) ((F1(KK,M),KK=1,KMAX),M=1,MMAX)
      DO 128 M=1,MMAX
      IF (M-N17) 123,118,123
  118 IF (XMIS(2)) 119,120,120
  119 IF (BBND(K)) 120,123,120
  120 DO 121 L=1,10
      SIG(K,M,L) = 0.0
  121 CONTINUE
      DO 122 KK = 1,KMAX
      SCAC(K,M,KK) = 0.0
  122 CONTINUE
      GO TO 128
  123 CONTINUE
      SIG(K,M,9) = SIG(K,M,1)*SIG(K,M,6)
      SPARE(98) = SPARE(98) + SIG(K,M,8)
C***************************SEARCH OPTIONS******************************
      IF (IX(5).NE.-2) GO TO 126
      IF ((IX(44).EQ.0).AND.(IX(49).EQ.0)) GO TO 125
      IF (IX(49).GT.0) GO TO 124
      IF ((M.EQ.IX(44)).OR.(M.EQ.IX(45)).OR.(M.EQ.IX(46))
     & .OR.(M.EQ.IX(47)).OR.(M.EQ.IX(48))) GO TO 125
      GO TO 126
  124 IF (IX(49).NE.NCLASS(M)) GO TO 126
  125 SIG(K,M,5) = SIG(K,M,9)
      SIG(K,M,9) = 0.0
  126 CONTINUE
      DO 127 KK = 1,KMAX
      SCAC(K,M,KK) = F1(KK,M)
  127 CONTINUE
  128 CONTINUE
  129 CONTINUE
      REWIND IO14
      T1 = 0.0
      DO 136 K = 1,KMAX
      DO 135 M=1,MMAX
      TPTSA=0.D+0
      DO 130 KK = 1,KMAX
      TPTSA = TPTSA + SCAC(K,M,KK)
  130 CONTINUE
      SIG(K,M,2) = TPTSA
      TPTSA = TPTSA + SIG(K,M,3) + SIG(K,M,9)
      SIG(K,M,10) = TPTSA
      SIG(K,M,3) = SIG(K,M,10) - SIG(K,M,2) - SIG(K,M,9)
      IF ((SIG(K,M,10).EQ.0.0).OR.(SIG(K,M,5).EQ.0.0)) GO TO 131
      SPARE(51) = AMAX1(SPARE(51),SIG(K,M,5)/SIG(K,M,10))
C****************************SEARCH OPTIONS*****************************
  131 CONTINUE
      IF (IX(5).EQ.(-5)) GO TO 134
      IF ((IX(5).EQ.0).OR.(IX(5).GE.2)) GO TO 134
      IF ((IX(44).EQ.0).AND.(IX(49).EQ.0)) GO TO 133
      IF (IX(49).GT.0) GO TO 132
      IF ((M.EQ.IX(44)).OR.(M.EQ.IX(45)).OR.(M.EQ.IX(46))
     & .OR.(M.EQ.IX(47)).OR.(M.EQ.IX(48))) GO TO 133
      GO TO 134
  132 IF (IX(49).NE.NCLASS(M)) GO TO 134
  133 T1 = T1 + SIG(K,M,5)
  134 CONTINUE
  135 CONTINUE
  136 CONTINUE
C****************************SEARCH OPTIONS*****************************
      IF (IX(5).EQ.(-5)) GO TO 138
      IF ((IX(5).EQ.0).OR.(IX(5).GE.2)) GO TO 138
  137 IF (T1.NE.0.0) GO TO 138
      JB = 16
      WRITE(IOUT,1000) JB
      WRITE(IOUT,2001)
      STOP
  138 CONTINUE
      NEM = NGEM-10
      DO 250 KT1=1,KMAX
      K = KT1
      N = KT1
      IF (IX37.EQ.0) GO TO 140
      N = 1
      IF (IX(71).GT.0) K = KMAXP1 - KT1
C**** ZERO DCONBE,DCONRE,DCONBK,PTSAE IF I/O
      DO 139 NIO=IX37,IX38
      A(NIO) = 0.0
  139 CONTINUE
C****
  140 CONTINUE
      DO 233 KB = 1,KBMAX
      L = KB
      TB = ZZ(KB+1)-ZZ(KB)
      DELFR = 0.0
      IF (KB-1) 142,142,141
  141 DELFR = ZZ(KB)-ZZ(KB-1)
  142 DELF = Z(KB)-ZZ(KB)
      DELK = ZZ(KB+1)-Z(KB)
      DELBK = 0.0
      IF (KB-KBMAX) 143,144,144
  143 DELBK = Z(KB+1)-ZZ(KB+1)
  144 CONTINUE
      DO 232 I = 1,IMAX
      NN1= (I-1)*JVX
      NN2= (I-1)*JVXP1
      N12 = I*JVXP1
      T1 = YY(I+1)-YY(I)
      DELTT = 0.0
      IF (I-1) 146,146,145
  145 DELTT = YY(I)-Y(I-1)
      IF (NEM.EQ.4) DELTT = YY(I)-PDI(I-1)
  146 DELT = Y(I)-YY(I)
      DELB = YY(I+1)-Y(I)
      IF (NEM.EQ.4) DELB = YY(I+1)-PDI(I)
      DELBB = 0.0
      IF (I-IMAX) 147,148,148
  147 DELBB = Y(I+1)-YY(I+1)
  148 CONTINUE
      DO 231 J = 1,JMAX
      NRN = NRGNE(J,I,KB)
      NOE = J-(J/2)*2
      N1= NN1 + J
      N2 = N1 + JVX
      N3= NN2 + J
      N4 = N3 + 1
      N5 = N3 + JVXP1
      DELLL = 0.0
      IF (J-1) 150,150,149
  149 DELLL = XX(J)-X(J-1)
      IF (NEM.EQ.4) N2 = N2-1
  150 DELL = X(J)-XX(J)
      DELR = XX(J+1)-X(J)
      DELRR = 0.0
      IF (J-JMAX) 151,152,152
  151 DELRR = X(J+1)-XX(J+1)
  152 CONTINUE
      GO TO (159,158,153,160),NEM
  153 TAT=SQUIRE*DELT*TB
      TAL=SQUIRE*DELL*TB
      TAR=DELR+DELL
      TAB=DELB+DELT
      TD1 = X(J+1)-X(J)
  154 TD2 = Y(I)-Y(I-1)
      IF (I.EQ.1) TD2 = 2*Y(I)
      IF (J.EQ.JMAX) TD1 = TD2
      DELHT = 0.5*SQRT(TD1**2+TD2**2-TD1*TD2)
      DELHB = DELHT
      TAR=TAL
      TAB=TAT
      TAH=SQUIRE*DELHT*TB
      TABK=SQUIRE*(DELT**2+DELL**2+DELHT**2)
      TAF = TABK
      MH=0
      IF (J-JMAX) 155,157,157
  155 IF (I-1) 157,157,156
  156 NHN=NRGNE(J+1,I-1,KB)
      MH=NCOMP(NHN)
  157 GO TO 162
  158 T2 = XX(J+1)-XX(J)
      TAL = TB*T1
      TAR = TAL
      TAT = YY(I)*T2*TB
      TAB = YY(I+1)*T2*TB
      TAF = 0.5*(YY(I+1)**2-YY(I)**2)*T2
      TABK = TAF
      DELR = DELR*Y(I)
      DELRR = DELRR*Y(I)
      DELL = DELL*Y(I)
      DELLL = DELLL*Y(I)
      GO TO 162
  159 TAL = T1*TB
      TAR = TAL
      TAT = (XX(J+1)-XX(J))*TB
      TAB = TAT
      TAF = (XX(J+1)-XX(J))*T1
      TABK = TAF
      GO TO 162
  160 CONTINUE
      TAL = 3.46410*(X(J)-XX(J))*TB
C     2*SQRT(3) = 3.46410
      TAR = 3.46410*(XX(J+1)-X(J))*TB
      TAF = PVOL(NRN)/TB
      TABK = TAF
      IF (NOE.EQ.0) GO TO 161
      TAT = 3.46410*(Y(I)-YY(I))*TB
      TAB = 0.0
      GO TO 162
  161 CONTINUE
      TAB = 3.46410*(YY(I+1)-PDI(I))*TB
      TAT = 0.0
  162 CONTINUE
      M = NCOMP(NRN)
      IF (KB.EQ.1) GO TO 163
      NRNF = NRGNE(J,I,KB-1)
      MF = NCOMP(NRNF)
  163 IF (I.EQ.1) GO TO 164
      NRNT = NRGNE(J,I-1,KB)
      IF ((NEM.EQ.4).AND.(J.LT.JMAX)) NRNT = NRGNE(J+1,I-1,KB)
      MT = NCOMP(NRNT)
  164 IF (J.EQ.1) GO TO 165
      NRNL = NRGNE(J-1,I,KB)
      ML = NCOMP(NRNL)
      GO TO 166
  165 IF (INRB.NE.2) GO TO 166
      NRNL = NRGNE(JMAX,I,KB)
      ML = NCOMP(NRNL)
  166 IF (KB.EQ.KBMAX) GO TO 167
      NRNBK = NRGNE(J,I,KB+1)
      MBK = NCOMP(NRNBK)
  167 IF (I.EQ.IMAX) GO TO 168
      NRNB = NRGNE(J,I+1,KB)
      IF ((NEM.EQ.4).AND.(J.GT.1)) NRNB = NRGNE(J-1,I+1,KB)
      MB = NCOMP(NRNB)
      GO TO 169
  168 IF (INRB.NE.3) GO TO 169
      NRNB = NRGNE(JVX,J,KB)
      IF (NGEM.EQ.14) NRNB = NRGNE(JVX,J/2,KB)
      MB = NCOMP(NRNB)
      DELB = XX(JVXP1) - X(JVX)
  169 IF (J.EQ.JMAX) GO TO 170
      NRNR = NRGNE(J+1,I,KB)
      MR = NCOMP(NRNR)
      GO TO 174
  170 GO TO (174,171,172,173),INRB
  171 CONTINUE
      NRNR = NRGNE(1,I,KB)
      MR = NCOMP(NRNR)
      DELRR = X(1)
      IF(NGEM.EQ.2) DELRR = DELRR*Y(I)
      GO TO 174
  172 CONTINUE
      NRNR = NRGNE(I,IVX,KB)
      IF (NGEM.EQ.14) NRNR = NRGNE(2*I,IVX,KB)
      MR = NCOMP(NRNR)
      DELRR = YY(IVXP1) - Y(IVX)
      IF (NGEM.EQ.14) DELRR = YY(IVXP1)-PDI(IVX)
      GO TO 174
  173 CONTINUE
      NRNR = NRGNE(JVX,IVXP1-I,KB)
      MR = NCOMP(NRNR)
      DELRR = DELR
  174 CONTINUE
      IF (M.NE.N17) GO TO 175
      IF (XMIS(2).GE.0.0) GO TO 198
      IF (BBND(K).NE.0.0) GO TO 198
  175 IF (KB.GT.1) GO TO 176
C     DCONBK(N1 ,KB,N) = BND(5,K)*TAF/(1.0+DELF*BND(5,K)/SIG(K,M,1))
      DCONBK(N1 ,KB,N) = BND(5,K)*TAF/(1.0+DELF*BND(5,K)/SIG(K,M,12))
  176 IF (I.GT.1) GO TO 177
C     DCONBE(N1 ,KB,N) = BND(2,K)*TAT/(1.0+DELT*BND(2,K)/SIG(K,M,1))
      DCONBE(N1 ,KB,N) = BND(2,K)*TAT/(1.0+DELT*BND(2,K)/SIG(K,M,11))
  177 IF (J.GT.1) GO TO 178
      IF (INRB.EQ.2) GO TO 178
      DCONRE(N3 ,KB,N) = BND(1,K)*TAL/(1.0+DELL*BND(1,K)/SIG(K,M,1))
  178 IF (KB.LT.KBMAX) GO TO 179
C     DCONBK(N1 ,KB+1,N) = BND(6,K)*TABK/(1.0+DELK*BND(6,K)/SIG(K,M,1))
      DCONBK(N1 ,KB+1,N) = BND(6,K)*TABK/(1.0+DELK*BND(6,K)/SIG(K,M,12))
      IF (DCONBK(N1,KB+1,N).EQ.0.0) DCONBK(N1 ,KB+1,N) = 4096.0E-13
  179 IF (I.LT.IMAX) GO TO 180
C     DCONBE(N2 ,KB,N) = BND(4,K)*TAB/(1.0+DELB*BND(4,K)/SIG(K,M,1))
      DCONBE(N2 ,KB,N) = BND(4,K)*TAB/(1.0+DELB*BND(4,K)/SIG(K,M,11))
      IF (DCONBE(N2,KB,N).EQ.0.0) DCONBE(N2 ,KB,N) = 4096.0E-13
  180 IF (J.LT.JMAX) GO TO 181
      IF (INRB.GT.1) GO TO 181
      DCONRE(N4 ,KB,N) = BND(3,K)*TAR/(1.0+DELR*BND(3,K)/SIG(K,M,1))
      IF (DCONRE(N4,KB,N).EQ.0.0) DCONRE(N4 ,KB,N) = 4096.0E-13
      GO TO 182
  181 DCONRE(N4 ,KB,N) = TAR*SIG(K,MR,1)/(DELRR+DELR*SIG(K,MR,1)/ SIG(K,
     &  M,1))
      IF (DCONRE(N4,KB,N).EQ.0.0) DCONRE(N4 ,KB,N) = 4096.0E-13
  182 IF (I.GE.IMAX) GO TO 183
C     DCONBE(N2 ,KB,N) = TAB*SIG(K,MB,1)/(DELBB+DELB*SIG(K,MB,1)/ SIG(K,
C    &  M,1))
      DCONBE(N2 ,KB,N)=TAB*SIG(K,MB,11)/(DELBB+DELB*SIG(K,MB,11)/ SIG(K,
     &  M,11))
      IF (DCONBE(N2,KB,N).EQ.0.0) DCONBE(N2 ,KB,N) = 4096.0E-13
  183 IF (KB.GE.KBMAX) GO TO 184
C     DCONBK(N1 ,KB+1,N) = TABK*SIG(K,MBK,1)/(DELBK+DELK*SIG(K,MBK,1)/
C    & SIG(K,M,1))
      DCONBK(N1 ,KB+1,N)=TABK*SIG(K,MBK,12)/(DELBK+DELK*SIG(K,MBK,12)/
     & SIG(K,M,12))
      IF (DCONBK(N1,KB+1,N).EQ.0.0) DCONBK(N1 ,KB+1,N) = 4096.0E-13
  184 CONTINUE
      IF (N17.LE.0) GO TO 198
      IF (XMIS(2).GE.0.0) GO TO 185
      IF (BBND(K).EQ.0.0) GO TO 198
  185 IF (KBMAX.LE.1) GO TO 188
      IF (KB.EQ.KBMAX) GO TO 187
      IF (MBK.NE.N17) GO TO 186
C     DCONBK(N1,KB+1,N) = BBND(K)*TABK/(1.0+DELK*BBND(K)/SIG(K,M,1))
      DCONBK(N1,KB+1,N) = BBND(K)*TABK/(1.0+DELK*BBND(K)/SIG(K,M,12))
      IF (DCONBK(N1,KB+1,N).EQ.0.0) DCONBK(N1 ,KB+1,N) = 4096.0E-13
  186 IF (KB.EQ.1) GO TO 188
  187 IF (MF.NE.N17) GO TO 188
C     DCONBK(N1 ,KB,N) = BBND(K)*TAF/(1.0+DELF*BBND(K)/SIG(K,M,1))
      DCONBK(N1 ,KB,N) = BBND(K)*TAF/(1.0+DELF*BBND(K)/SIG(K,M,12))
  188 CONTINUE
      IF (IMAX.LE.1) GO TO 193
      IF (I.NE.IMAX) GO TO 190
      IF (INRB.NE.3) GO TO 191
      IF (MB.NE.N17) GO TO 191
C     DCONBE(N2 ,KB,N) = BBND(K)*TAB/(1.0+DELB*BBND(K)/SIG(K,M,1))
      DCONBE(N2 ,KB,N) = BBND(K)*TAB/(1.0+DELB*BBND(K)/SIG(K,M,11))
      IF (DCONBE(N2,KB,N).EQ.0.0) DCONBE(N2 ,KB,N) = 4096.0E-13
      IF (NGEM.EQ.14) GO TO 189
      DCONRE(N12,KB,N) = DCONBE(N2,KB,N)
      GO TO 191
  189 CONTINUE
      IF ((J/2)*2.NE.J) GO TO 191
      N122 = (J/2-1)*JVXP1+JVXP1
      DCONRE(N122,KB,N) = DCONBE(N2,KB,N)
      GO TO 191
  190 IF (MB.NE.N17) GO TO 191
C     DCONBE(N2 ,KB,N) = BBND(K)*TAB/(1.0+DELB*BBND(K)/SIG(K,M,1))
      DCONBE(N2 ,KB,N) = BBND(K)*TAB/(1.0+DELB*BBND(K)/SIG(K,M,11))
      IF (DCONBE(N2,KB,N).EQ.0.0) DCONBE(N2 ,KB,N) = 4096.0E-13
  191 IF (I.EQ.1) GO TO 193
  192 IF (MT.NE.N17) GO TO 193
C     DCONBE(N1 ,KB,N) = BBND(K)*TAT/(1.0+DELT*BBND(K)/SIG(K,M,1))
      DCONBE(N1 ,KB,N) = BBND(K)*TAT/(1.0+DELT*BBND(K)/SIG(K,M,11))
  193 CONTINUE
      IF (JMAX.LE.1) GO TO 198
      IF (J.LT.JMAX) GO TO 194
      IF (INRB.LE.1) GO TO 197
  194 IF (MR.NE.N17) GO TO 196
      DCONRE(N4 ,KB,N) = BBND(K)*TAR/(1.0+DELR*BBND(K)/SIG(K,M,1))
      IF (DCONRE(N4,KB,N).EQ.0.0) DCONRE(N4,KB,N) = 4096.0E-13
C     IF (INRB.NE.4) GO TO 195
C     N11 = IVXP1*JVXP1 - N12
C     DCONRE(N11,KB,N) = DCONRE(N12,KB,N)
  195 CONTINUE
  196 IF (J.GT.1) GO TO 197
      IF (INRB.NE.2) GO TO 198
      IF (ML.NE.N17) GO TO 198
      DCONRE(N12,KB,N) = BBND(K)*TAL/(1.0+DELL*BBND(K)/SIG(K,M,1))
      IF (DCONRE(N12,KB,N).EQ.0.0) DCONRE(N12,KB,N) = 4096.0E-13
      GO TO 198
  197 IF (ML.NE.N17) GO TO 198
      DCONRE(N3 ,KB,N) = BBND(K)*TAL/(1.0+DELL*BBND(K)/SIG(K,M,1))
      IF (DCONRE(N3,KB,N).EQ.0.0) DCONRE(N3,KB,N) = 4096.0E-13
  198 CONTINUE
      IF (NEM-3) 230,199,230
  199 KKK = IOVX + N
      IF (N17) 200,200,201
  200 CONTINUE
      IF (J.EQ.JMAX) GO TO 211
      IF (I.EQ.1) GO TO 226
      DCONRE(N4 ,KB,KKK)=TAH*SIG(K,MH,1)/(DELHT+DELHB*SIG(K,MH,1)/
     & SIG(K,M,1))
      GO TO 210
  201 IF (XMIS(2)) 202,204,204
  202 IF (BBND(K)) 200,200,204
  203 DCONRE(N4 ,KB,KKK)=0
      GO TO 210
  204 IF (MH-N17) 207,205,207
  205 IF (M-N17) 206,203,206
  206 DCONRE(N4 ,KB,KKK)=BBND(K)*TAH/(1.0+DELHT*BBND(K)/SIG(K,M,1))
      GO TO 210
  207 IF (M-N17) 200,208,200
  208 IF (MH) 203,203,209
  209 DCONRE(N4 ,KB,KKK)=BBND(K)*TAH/(1.0+DELHB*BBND(K)/SIG(K,MH,1))
  210 IF (J-JMAX) 218,211,211
  211 DCONRE(N4 ,KB,KKK)=0
      IF (I-1) 212,212,216
  212 IF (DCONRE(N4,KB,N)-4096.0E-13) 213,214,213
  213 DCONRE(N4 ,KB,N)=1.5*DCONRE(N4 ,KB,N)/SQUIRE
  214 IF (DCONBE(N1,KB,N)-4096.0E-13) 215,226,215
  215 DCONBE(N1 ,KB,N)=1.5*DCONBE(N1 ,KB,N)/SQUIRE
      GO TO 226
  216 IF (DCONRE(N4,KB,N)-4096.0E-13) 217,218,217
  217 DCONRE(N4 ,KB,N)=2.0*DCONRE(N4 ,KB,N)/SQUIRE
  218 IF (I-IMAX) 226,219,219
  219 DCONRE(N5 ,KB,KKK)=0
      IF (J-1) 220,220,224
  220 IF (DCONRE(N3,KB,N)-4096.0E-13) 221,222,221
  221 DCONRE(N3 ,KB,N)=1.5*DCONRE(N3 ,KB,N)/SQUIRE
  222 IF (DCONBE(N2,KB,N)-4096.0E-13) 223,226,223
  223 DCONBE(N2 ,KB,N)=1.5*DCONBE(N2 ,KB,N)/SQUIRE
      GO TO 226
  224 IF (DCONBE(N2,KB,N)-4096.0E-13) 225,226,225
  225 DCONBE(N2 ,KB,N)=2.0*DCONBE(N2 ,KB,N)/SQUIRE
  226 IF (I-1) 227,227,228
  227 DCONRE(N4 ,KB,KKK)=0
      IF (J.NE.JMAX) DCONBE( J,KB,N)=2.0*DCONBE( J,KB,N)/SQUIRE
  228 IF (J-1) 229,229,230
  229 DCONRE(N5 ,KB,KKK)=0
      IF (I.NE.IMAX) DCONRE(N3 ,KB,N)=2.0*DCONRE(N3 ,KB,N)/SQUIRE
  230 CONTINUE
  231 CONTINUE
  232 CONTINUE
  233 CONTINUE
      IF (INRB.LE.1) GO TO 242
      DO 241 KB=1,KBMAX
      GO TO (240,238,236,234),INRB
  234 CONTINUE
      I = IVX/2
      J2 = IVXP1*JVXP1
      DO 235 LL=1,I
      N12 = LL*JVXP1
      N11 = J2 - N12
      DCONRE(N11,KB,N) = DCONRE(N12,KB,N)
  235 CONTINUE
      GO TO 240
  236 CONTINUE
      DCONRE(JP1IXZ,KB,N) = 4096.0E-13
      LJ = 1
      DO 237 LL = 1,IVX
      N12 = LL*JVXP1
      N14 = JIVX+LJ
      DCONBE(N14,KB,N) = DCONRE(N12,KB,N)
      LJ = LJ+1
      IF (NGEM.EQ.14) LJ = LJ+1
  237 CONTINUE
      GO TO 240
  238 CONTINUE
      DO 239 I=1,IVX
      N12 = I*JVXP1
      N15 = N12 - JVX
      DCONRE(N15,KB,N) = DCONRE(N12,KB,N)
  239 CONTINUE
  240 CONTINUE
  241 CONTINUE
  242 CONTINUE
      DO 249 KB=1,KBMAX
      DO 248 I=1,IMAX
      NN1= (I-1)*JVX
      NN2= (I-1)*JVXP1
      DO 247 J=1,JMAX
      N1= NN1 + J
      N2 = N1 + JVX
      N3= NN2 + J
      N4 = N3 + 1
      N5 = N3 + JVXP1
      NRN = NRGNE(J,I,KB)
      M = NCOMP(NRN)
      D1 = DCONBE(N1 ,KB,N)
      IF (NEM.NE.4) GO TO 243
      IF (J.EQ.1) D2 = 0.0
      IF (J.EQ.1) GO TO 244
      N2 = N2-1
  243 CONTINUE
      D2 = DCONBE(N2 ,KB,N)
  244 CONTINUE
      D3 = DCONRE(N3 ,KB,N)
      D4 = DCONRE(N4 ,KB,N)
      D5 = DCONBK(N1 ,KB,N)
      D6 = DCONBK(N1 ,KB+1,N)
      D9 = SIG(K,M,10)
C
C
      TPTSA = D1+D2+D3+D4+D5+D6+D9*PVOL(NRN)
      IF (NEM.NE.3) GO TO 245
      D7 = DCONRE(N5 ,KB,KKK)
      D8 = DCONRE(N4 ,KB,KKK)
      TPTSA = TPTSA + D7+D8
  245 CONTINUE
      PTSAE(N1 ,KB,N) = TPTSA
      IF ((TPTSA.EQ.0.0).OR.(SIG(K,M,5).EQ.0.0)) GO TO 246
      SPARE(57) = AMAX1(SPARE(57),SIG(K,M,5)*PVOL(NRN)/PTSAE(N1,KB,N))
  246 CONTINUE
  247 CONTINUE
  248 CONTINUE
  249 CONTINUE
      IF (IX37.EQ.0) GO TO 250
      WRITE(IOADJ) AIO
  250 CONTINUE
      IF (IX37.EQ.0) GO TO 251
C     END FILE IOADJ
      REWIND IOADJ
  251 CONTINUE
C     DIAGONAL SYMMETRY CHECKOUT
      IF (IX(71).GT.0) GO TO 271
      IF (NUAC(8)) 254,271,252
  252 IF (IMAX-JMAX) 253,262,253
  253 NUAC(8)=0
      WRITE(IOUT,1001)
      GO TO 270
  254 II=IMAX/2
      DO 261 N=1,KMAX
      K = N
      IF (IX37.EQ.0) GO TO 255
      K = 1
      READ(IO15) AIO
  255 CONTINUE
      DO 260I=1,II
      L=IMAX-I+1
      NN1= (I-1)*JVX
      NN2= (L-1)*JVX
      DO 259J=1,JMAX
      M=JMAX-J+1
      N6= NN1 + J
      N7= NN2 + M
      DO 258KB=1,KBMAX
      MT=NRGNE(J,I,KB)
      ML=NRGNE(M,L,KB)
      IF (NCOMP(MT)-NCOMP(ML)) 253,256,253
  256 CONTINUE
      IF (PTSAE(N6,KB,K).EQ.0) GO TO 257
      IF (ABS(PTSAE(N7,KB,K)/PTSAE(N6,KB,K)-1.0)-EPICH) 257,253,253
  257 CONTINUE
  258 CONTINUE
  259 CONTINUE
  260 CONTINUE
  261 CONTINUE
      GO TO 270
  262 CONTINUE
      DO 269 N=1,KMAX
      K = N
      IF (IX37.EQ.0) GO TO 263
      K = 1
      READ(IO15) AIO
  263 CONTINUE
      DO 268 KB=1,KBMAX
      DO 267I=1,IMAX
      NN1= (I-1)*JVX
      DO 266J=1,JMAX
      N6= NN1 + J
      N8 = (J-1)*JVX + I
      MT=NRGNE(J,I,KB)
      ML=NRGNE(I,J,KB)
      IF (NCOMP(MT)-NCOMP(ML)) 253,264,253
  264 CONTINUE
      IF (PTSAE(N8,KB,K).EQ.0) GO TO 265
      IF (ABS(PTSAE(N6,KB,K)/PTSAE(N8,KB,K)-1.0)-EPICH) 265,253,253
  265 CONTINUE
  266 CONTINUE
  267 CONTINUE
  268 CONTINUE
  269 CONTINUE
      NUAC(20)=0
  270 CONTINUE
      IF (IX37.GT.0) REWIND IO15
  271 CONTINUE
      IF (SPARE(51).NE.0.0) SPARE(51) = -1.0/SPARE(51)
      IF (SPARE(57).NE.0.0) SPARE(57) = -1.0/SPARE(57)
      IF (IX(71).GT.0) IX(5)= 0
      RETURN
C
 1000 FORMAT('0ERROR STOP',4I6)
 1001 FORMAT('0DIAGONAL SYMMETRY OPTION DENIED')
 2000 FORMAT(' THE MESH IS NOT SQUARE, OR NOT EQUAL IN THE X AND Y DIR',
     &       'ECTIONS FOR 90 DEGREE ROTATIONAL SYMMETRY.')
 2001 FORMAT(' NO INITIAL VALUES OF THE SEARCH PARAMETERS (1/V,B**2,OR',
     &       ' CONCENTRATIONS) WERE INPUT FOR DIRECT SEARCH.')
      END