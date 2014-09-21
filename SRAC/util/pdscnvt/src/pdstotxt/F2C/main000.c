/* main000.f -- translated by f2c (version 20100827).
   You must link the resulting object file with libf2c:
	on Microsoft Windows system, link with libf2c.lib;
	on Linux or Unix systems, link with .../path/to/libf2c.a -lm
	or, if you install libf2c.a in a standard place, with -lf2c -lm
	-- in that order, at the end of the command line, as in
		cc *.o -lf2c -lm
	Source for libf2c is in /netlib/f2c/libf2c.zip, e.g.,

		http://www.netlib.org/f2c/libf2c.zip
*/

#include "f2c.h"

/* Common Block Declarations */

struct {
    integer ntnuc1, ntnuc2, nzon2, nzon3;
} setdt_;

#define setdt_1 setdt_

/* Table of constant values */

static integer c__1 = 1;
static integer c__9 = 9;
static integer c__4000 = 4000;
static integer c__3 = 3;
static integer c_b48 = 300000;
static integer c__7 = 7;

/* ----------------------------------------------------------------------- */
/*     MAIN PROGRAM TO */
/*     CONVERT PDS TO TEXT FOR SRAC95-UNIX */
/*     OUTPUT TEXT FORMAT : */
/*      (1) FIRST LINE IS COMMENT */
/*      (2) COMMAND LINE FORMAT IS AS FOLLOWING: */
/*          *PUT  'MENBER'  N  'LENG' */
/*      (3) DATA FORMAT (12A=1PE12.5) FOR FLOATING NUMBER */
/*      (4) DATA FORMAT (12A=1X,I7,1X) FOR INTEGER NUMBER */
/*      (5) DATA FORMAT (12A=1X,A4,7X) FOR CHARACTER DATA */
/*      (6) 1-6 DATA(FLOATING OR INTEGER OR CHARACTER) IN A LINE */
/*      (7) FLOATING NUMBER ALWAYS INCLUDE '.' IN A DATA(A12) */
/*      (8) DATA LENGTH OF A MEMBER =< 999999(I6) */

/*      SAMPLE : */
/*      COMMENT(1 LINE) */
/*      *PUT CU050000 N      9 */
/*                0           0  1.00000E-01......... */
/*                1 -2.00000E-04        125 ......... */
/*      *PUT MU050000 N     14 */
/*       1.00000E+02 2.00000E-02-3.00000E-04......... */
/*       1.00000E+02 2.00000E-02-3.00000E-04......... */
/*      -1.00000E+02 2.00000E-02 */
/*      ........... */
/*      ........... */
/*      *FIN */

/*   SPECIAL TREATMENT WILL BE DONE TO TREAT CHARACTER DATA FOR THE */
/*   MEMBERS : ----DN-T IN MACRO/MACROWRK */
/*             ----BNUP IN MACRO/MACROWRK */
/*             ----REST IN MACRO/MACROWRK */
/* ----------------------------------------------------------------------- */
/*     TO EXECUTE THIS PROGRAM, USER MUST PREPARE MEMBER LIST FILE */
/*     WHICH CONTAIN LIST OF MEMBERS IN THE PDS FILE */
/*     THE MEMBER LIST FILE CAN EASILY GENERATED BY UNIX COMMAND */
/*         ALIAS LS LS */
/*         LS -C > MLIST.DAT */
/*         CAT MLIST.DAT */
/*         CU050000   CU08000   CPU00000   CPU10000  CPU20000 */
/*         CPU90000   CAM1000 */
/*     FORMAT OF MEMBER LIST IS FREE, BUT LENGTH OF MEMBER NAME MUST */
/*     BE LESS OR EQUAL 8, MEMBER NAME MUST BE DIVIDED BY SOME BLANKS, */
/*     MEMBER LIST MUST BE WRITTEN WITH IN 255 COLUMNS. */
/* ----------------------------------------------------------------------- */
/* Main program */ int MAIN__(void)
{
    /* System generated locals */
    address a__1[7];
    integer i__1, i__2[7], i__3, i__4;
    alist al__1;

    /* Builtin functions */
    /* Subroutine */ int s_copy(char *, char *, ftnlen, ftnlen);
    integer s_rsfe(cilist *), do_fio(integer *, char *, ftnlen), e_rsfe(void),
	     s_wsle(cilist *), do_lio(integer *, integer *, char *, ftnlen), 
	    e_wsle(void);
    /* Subroutine */ int s_stop(char *, ftnlen);
    integer f_rew(alist *), s_wsfe(cilist *), e_wsfe(void), s_wsfi(icilist *),
	     e_wsfi(void);
    /* Subroutine */ int s_cat(char *, char **, integer *, integer *, ftnlen);
    integer s_cmp(char *, char *, ftnlen, ftnlen);

    /* Local variables */
    static integer i__, l, m, ld;
    static char cmd[4];
    static integer irc;
    static real data[6];
    static integer leng;
    static char line[72];
    static integer nred, nmem, ipos, kpos, iout;
    static char type__[1];
    static real work[300000];
    static integer ldata;
    static char aleng[6];
    extern /* Subroutine */ int pdsin_(char *, char *, real *, integer *, 
	    integer *, integer *, ftnlen, ftnlen);
    static integer iomls, iotxt;
    extern /* Subroutine */ int setli1_(char *, integer *, real *, integer *, 
	    ftnlen), setli2_(char *, integer *, real *, integer *, ftnlen), 
	    setli3_(char *, integer *, real *, integer *, ftnlen);
    static char member[8], dirnam[72], memnam[8*4000];
    extern /* Subroutine */ int setlin_(char *, integer *, real *, ftnlen), 
	    memlst_(integer *, integer *, char *, ftnlen), uioset_(void), 
	    txtlin_(integer *, integer *);

    /* Fortran I/O blocks */
    static cilist io___7 = { 0, 5, 0, "(A72)", 0 };
    static cilist io___9 = { 0, 6, 0, 0, 0 };
    static cilist io___10 = { 0, 6, 0, 0, 0 };
    static cilist io___11 = { 0, 6, 0, 0, 0 };
    static cilist io___13 = { 0, 0, 0, "(A72)", 0 };
    static cilist io___16 = { 0, 6, 0, 0, 0 };
    static cilist io___22 = { 0, 6, 0, 0, 0 };
    static cilist io___23 = { 0, 6, 0, 0, 0 };
    static cilist io___24 = { 0, 6, 0, 0, 0 };
    static icilist io___26 = { 0, aleng, 0, "(I6)", 6, 1 };
    static cilist io___27 = { 0, 0, 0, "(A72)", 0 };
    static cilist io___35 = { 0, 0, 0, "(A72)", 0 };
    static cilist io___36 = { 0, 0, 0, "(A72)", 0 };
    static cilist io___37 = { 0, 0, 0, 0, 0 };
    static cilist io___38 = { 0, 0, 0, 0, 0 };
    static cilist io___39 = { 0, 0, 0, 0, 0 };



/* ----- IO DEVICE */
/*     IOTXT : TEXT PDS (WRITE) */
/*     IOMLS : MEMBER LIST (READ) */
/*      IOUT : STANDARD OUTPUT (WRITE) */
/*       49  : DEVICE FOR PDS MEMBER, INTERNALLY OPENED AND CLOSED (READ) */
/*        5  : STANDARD INPUT FOR DIRECTORY NAME OF PDS FILE */

    uioset_();
    iotxt = 10;
    iomls = 11;
    iout = 6;

    nred = 0;
    s_copy(cmd, "*PUT", (ftnlen)4, (ftnlen)4);
    *(unsigned char *)type__ = 'N';
/* ******************** */
/*  READ INPUT DATA  * */
/* ******************** */
/*     DIRNAM : FULL NAME OF DIRECTORY FOR PDS */
/*     EX:/DG05/UFS02/J9347/SRAC95/LIB/PDS/PFAST/PFASTJ2 */
    s_rsfe(&io___7);
    do_fio(&c__1, dirnam, (ftnlen)72);
    e_rsfe();
    if (*(unsigned char *)dirnam == ' ') {
	s_wsle(&io___9);
	do_lio(&c__9, &c__1, " ERROR(MAIN) : DIRECTORY NAME IS INVALID", (
		ftnlen)40);
	e_wsle();
	s_wsle(&io___10);
	do_lio(&c__9, &c__1, " THE FIRST COLUMN SHOULD BE NON-BLANK", (ftnlen)
		37);
	e_wsle();
	s_wsle(&io___11);
	do_lio(&c__9, &c__1, " DIRNAM = ", (ftnlen)10);
	do_lio(&c__9, &c__1, dirnam, (ftnlen)72);
	e_wsle();
	s_stop("", (ftnlen)0);
    }
/* ************************ */
/*  WRITE HEADER IN TEXT * */
/* ************************ */
    al__1.aerr = 0;
    al__1.aunit = iotxt;
    f_rew(&al__1);
    s_copy(line, "  3        PDSEDT INPUT R/W MODE  ", (ftnlen)72, (ftnlen)34)
	    ;
    io___13.ciunit = iotxt;
    s_wsfe(&io___13);
    do_fio(&c__1, line, (ftnlen)72);
    e_wsfe();
/* ******************** */
/*  READ MEMBER LIST * */
/* ******************** */
    memlst_(&iomls, &nmem, memnam, (ftnlen)8);
    if (nmem > 4000) {
	s_wsle(&io___16);
	do_lio(&c__9, &c__1, " ERROR (MAIN) : MAX OF MEMBER(MAXME=", (ftnlen)
		36);
	do_lio(&c__3, &c__1, (char *)&c__4000, (ftnlen)sizeof(integer));
	do_lio(&c__9, &c__1, ") IS LESS THAN REQUIRED SIZE(=", (ftnlen)30);
	do_lio(&c__3, &c__1, (char *)&nmem, (ftnlen)sizeof(integer));
	e_wsle();
	s_stop("", (ftnlen)0);
    }
/* ******************** */
/*  LOOP ON MEMBER   * */
/* ******************** */
    i__1 = nmem;
    for (m = 1; m <= i__1; ++m) {
	s_copy(member, memnam + (m - 1 << 3), (ftnlen)8, (ftnlen)8);
	setdt_1.ntnuc1 = 0;
	setdt_1.ntnuc2 = 0;
	setdt_1.nzon2 = 0;
	setdt_1.nzon3 = 0;
/* *************************** */
/*  READ CONTENTS OF MEMBER * */
/* *************************** */
	pdsin_(dirnam, member, work, &leng, &irc, &iout, (ftnlen)72, (ftnlen)
		8);
	if (irc != 0) {
	    s_wsle(&io___22);
	    do_lio(&c__9, &c__1, " PDS ERROR : ERROR CODE = ", (ftnlen)26);
	    do_lio(&c__3, &c__1, (char *)&irc, (ftnlen)sizeof(integer));
	    e_wsle();
	    s_wsle(&io___23);
	    do_lio(&c__9, &c__1, " MEMBER = ", (ftnlen)10);
	    do_lio(&c__9, &c__1, member, (ftnlen)8);
	    e_wsle();
	    s_stop("", (ftnlen)0);
	} else {
	    ++nred;
	}
	if (leng > 300000) {
	    s_wsle(&io___24);
	    do_lio(&c__9, &c__1, " ERROR (MAIN) : WORK AREA(MAXWK=", (ftnlen)
		    32);
	    do_lio(&c__3, &c__1, (char *)&c_b48, (ftnlen)sizeof(integer));
	    do_lio(&c__9, &c__1, ") IS LESS THAN REQUIRED SIZE(=", (ftnlen)30)
		    ;
	    do_lio(&c__3, &c__1, (char *)&leng, (ftnlen)sizeof(integer));
	    do_lio(&c__9, &c__1, " IN MEMBER:", (ftnlen)11);
	    do_lio(&c__9, &c__1, member, (ftnlen)8);
	    e_wsle();
	    s_stop("", (ftnlen)0);
	}
/* ***************** */
/*  WRITE IN TEXT * */
/* ***************** */
/* ----- WRITE MEMBER NAME AND LENGTH */
	s_wsfi(&io___26);
	do_fio(&c__1, (char *)&leng, (ftnlen)sizeof(integer));
	e_wsfi();
/* Writing concatenation */
	i__2[0] = 4, a__1[0] = cmd;
	i__2[1] = 1, a__1[1] = " ";
	i__2[2] = 8, a__1[2] = member;
	i__2[3] = 1, a__1[3] = " ";
	i__2[4] = 1, a__1[4] = type__;
	i__2[5] = 1, a__1[5] = " ";
	i__2[6] = 6, a__1[6] = aleng;
	s_cat(line, a__1, i__2, &c__7, (ftnlen)72);
	io___27.ciunit = iotxt;
	s_wsfe(&io___27);
	do_fio(&c__1, line, (ftnlen)72);
	e_wsfe();
/* ----- SET NUMBER OF LINES TO WRITE IN TEXT FOR DATA OF A MEMBER */
	txtlin_(&leng, &ldata);
/* ----- SET LINE DATA AND WRITE IN TEXT */
	i__3 = ldata;
	for (l = 1; l <= i__3; ++l) {
	    kpos = (l - 1) * 6 + 1;
	    if (l != ldata) {
		ld = 6;
	    } else {
		ld = leng - (ldata - 1) * 6;
	    }
	    i__4 = ld;
	    for (i__ = 1; i__ <= i__4; ++i__) {
		ipos = (l - 1) * 6 + i__;
		data[i__ - 1] = work[ipos - 1];
/* L110: */
	    }
	    if (s_cmp(member + 4, "DN", (ftnlen)2, (ftnlen)2) == 0 && *(
		    unsigned char *)&member[7] == 'T') {
		setli1_(line, &ld, data, &kpos, (ftnlen)72);
	    } else if (s_cmp(member + 4, "BNUP", (ftnlen)4, (ftnlen)4) == 0) {
		setli2_(line, &ld, data, &kpos, (ftnlen)72);
	    } else if (s_cmp(member + 4, "REST", (ftnlen)4, (ftnlen)4) == 0) {
		setli3_(line, &ld, data, &kpos, (ftnlen)72);
	    } else {
		setlin_(line, &ld, data, (ftnlen)72);
	    }
	    io___35.ciunit = iotxt;
	    s_wsfe(&io___35);
	    do_fio(&c__1, line, (ftnlen)72);
	    e_wsfe();
/* L100: */
	}

/* L1000: */
    }
/* *********** */
/*  FINISH  * */
/* *********** */
    s_copy(line, "*FIN", (ftnlen)72, (ftnlen)4);
    io___36.ciunit = iotxt;
    s_wsfe(&io___36);
    do_fio(&c__1, line, (ftnlen)72);
    e_wsfe();
    io___37.ciunit = iout;
    s_wsle(&io___37);
    e_wsle();
    io___38.ciunit = iout;
    s_wsle(&io___38);
    do_lio(&c__9, &c__1, " NUMBER OF MEMBERS READ FROM PDS=", (ftnlen)33);
    do_lio(&c__3, &c__1, (char *)&nred, (ftnlen)sizeof(integer));
    e_wsle();
    io___39.ciunit = iout;
    s_wsle(&io___39);
    do_lio(&c__9, &c__1, " ********** JOB END **********", (ftnlen)30);
    e_wsle();
    s_stop("", (ftnlen)0);
    return 0;
} /* MAIN__ */

/* *********************************************************************** */

/*  UIOUNT   : SET UNFORMATED(0) OR FORMATED(1) */
/*             FOR EACH I/O DEVICE */

/* *********************************************************************** */

/* Subroutine */ int uiount_(integer *ioform)
{
    static integer i__;

    /* Parameter adjustments */
    --ioform;

    /* Function Body */
    for (i__ = 1; i__ <= 100; ++i__) {
	ioform[i__] = -1;
/* L100: */
    }
    ioform[5] = 1;
    ioform[6] = 1;
    ioform[10] = 1;
    ioform[11] = 1;
    return 0;
} /* uiount_ */

