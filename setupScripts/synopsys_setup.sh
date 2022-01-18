#!/bin/tcsh

############################################
# Set the base directory for Synopsys tools#
############################################
setenv synopsys_dir "/uusoc/facility/cad_tools/Synopsys"
#setenv synopsys_dir_lnis "/uusoc/facility/cad_tools/Synopsys/lnis_tools"
# the lnis is not findable currently???
setenv synopsys_dir_lnis "/uusoc/facility/cad_tools/Synopsys"
setenv mentor_dir "/uusoc/facility/cad_tools/Menotor"

###############################
## Licenses for Synopsys tools#
###############################
setenv SNPSLMD_LICENSE_FILE 27000@chickasaw.eng.utah.edu


######################################
##  SYNOPSYS HSPICE (spice simulator)#
######################################
source $synopsys_dir_lnis/hspice_Q-2020.03-2/hspice/bin/cshrc.meta
#source $synopsys_dir_lnis/Q-2020.03-2/hspice/bin/cshrc.meta
set path=($path $HSP_HOME/hspice/bin)


###########################################
##  SYNOPSYS ICC2 (P&R for advanced nodes)#
###########################################
setenv ICC2_HOME $synopsys_dir_lnis/icc2/P-2019.03-SP4
set path=($path $ICC2_HOME/bin)


###############################################################################
##  SYNOPSYS PrimeTime (for signoff: static timing analysis, signal integrity)#
###############################################################################
setenv PRIMETIME_HOME $synopsys_dir_lnis/pts/P-2019.03-SP2
set path=($path $PRIMETIME_HOME/bin)


######################################################
##  SYNOPSYS PrimePower (for signoff: power analysis)#
######################################################
setenv PRIMEPOWER_HOME $synopsys_dir_lnis/pwr/P-2019.03-SP2
set path=($path $PRIMEPOWER_HOME/bin)


##############################################
##  SYNOPSYS Sentaurus (TCAD/Device modeling)#
##############################################
setenv SENTAURUS_HOME $synopsys_dir_lnis/sentaurus/P_2019.03-SP1
set path=($path $SENTAURUS_HOME/bin)



#########################################
##  SYNOPSYS Design Compiler (synthesis)#
#########################################
setenv DC_HOME $synopsys_dir_lnis/syn/P-2019.03-SP5
set path=($path $DC_HOME/bin)


##############################################
##  SYNOPSYS FORMALITY (Equivalence checking)#
##############################################
setenv FM_HOME $synopsys_dir_lnis/fm/P-2019.03-SP2
set path=($path $FM_HOME/bin)


#######################################
##  SYNOPSYS Tetramax (for IC testing)#
#######################################
setenv TMAX_HOME $synopsys_dir_lnis/txs/P-2019.03-SP2
set path=($path $TMAX_HOME/bin)


#################################
##  SYNOPSYS IDQQ (power fault) #
#################################
setenv IDQ_HOME $synopsys_dir_lnis/idq/P-2019.03-SP2
set path=($path $IDQ_HOME/bin)


############################################
##  SYNOPSYS Library Compiler (.lib to .db)#
############################################
setenv LC_HOME $synopsys_dir_lnis/lc/P-2019.03-SP2
set path=($path $LC_HOME/bin)


##################################
##  SYNOPSYS VCS (HDL simulator) #
##################################
setenv VCS_HOME $synopsys_dir_lnis/vcs/P-2019.06-SP1
set path=($path $VCS_HOME/bin)


########################################################
##  SYNOPSYS Verdi (to analyze hdl simulation results) #
########################################################
setenv VERDI_HOME $synopsys_dir_lnis/verdi/P-2019.06-SP1-1
set path=($path $VERDI_HOME/bin)


#############################################################
##  SYNOPSYS CUSTOM WAVEVIEW (to display simulation results)#
#############################################################
setenv CX_HOME $synopsys_dir/wv/S-2021.09
set path=($path $CX_HOME/bin)

#############################################################
##  EZWAVE (to display simulation results)#
#############################################################
setenv EZWAVE_HOME $mentor_dir/AMSV_20.2/amsv/
set path=($path $EZWAVE_HOME/bin)

############################
##  SYNOPSYS StarRCXT (PEX)#
############################
setenv RCXT_HOME_DIR $synopsys_dir_lnis/starrc/P-2019.03-SP4/linux64_starrc
setenv AVANTI_STAR_HOME_DIR $RCXT_HOME_DIR
set path=($path $AVANTI_STAR_HOME_DIR/bin)
