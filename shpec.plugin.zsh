##########################################################
#							 #
#                _____ __                   		 #
#               / ___// /_  ____  ___  _____		 #
#               \__ \/ __ \/ __ \/ _ \/ ___/		 #
#              ___/ / / / / /_/ /  __/ /__  		 #
#             /____/_/ /_/ .___/\___/\___/  		 #
#                       /_/                 		 #
#        						 #
##########################################################


## just create a variable shpec pointing to where the spec
## executable really is (in this folder)
__shpec_location="$(dirname $0:A)/bin/shpec"
shpec() {
  # $@ is already defined, pass it to shpec
  (
      disable -r end;
      . $__shpec_location;
  )
}
