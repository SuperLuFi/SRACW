######################################################################
#    run PDSMDL
#    main : BnupEdit : print burnup calulation results in members 
#                      ????BNUP/????DN?T     (by Leben Asa)
######################################################################
#
# Fortran logical unit usage
#   6   standard output
#  49   device used for PDS files (internally defined) 
#  99   text:message from PDSMDL (PDS read/write monitor)
#
#=============  Set by user ===================================
$SRAC_DIR = "E:\SRACW\SRAC"
#  LMD    : load module name
#  ODR    : directory in which output data will be stored
#  CASE   : case name which is refered as output file name
#  MACRO  : directory name of MACRO/MACROWRK PDS(A72)
#     
$LMN = "BnupEdit.exe"
$ODR = "$SRAC_DIR\tmp"
$CASE = "BnupEdit"
$MACRO = "$SRAC_DIR\tmp\Sample\MACRO"
#  
#=============  Change if you like ============================
#
$LM = "$SRAC_DIR\util\pdsmdl\bin\$LMN"
$DATE = Get-Date -uformat "%Y.%m.%d.%H.%M.%S"
$env:fu99 = "$ODR\pdsmdl99.$CASE.$DATE"
$OUTLST = "$ODR\pdsmdl06.$CASE.$DATE"
#
#=============  Exec user's PDSMDL code =======================
# 
# INPUT (1) : directory name of MACRO/MACROWRK
# INPUT (2) : member name(A8), repeat until a blank card is entered
#
$Input = @"
$MACRO
SMPLBNUP
SMPLDN1T

"@
$Input | &"$LM" >> $OUTLST
#  rm $ODR/pdsmdl99.$CASE.$DATE
