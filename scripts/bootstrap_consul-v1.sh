#!/bin/bash -e
# Hashicorp Consul Bootstraping v1
# authors: tonynv@amazon.com, bchav@amazon.com
# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD you much install GNU getopt



# PARSER ARGUMENTS
PROGRAM='HashiCorp Consul'

##################################### Functions
function checkos () {
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
else
   echo "[WARINING] This script is not supported on MacOS or freebsd"
   exit 1
fi
}

function usage () {
echo "$0 <usage>"
echo " "
echo "options:"
echo -e  "-h, --help \t show options for this script"
echo -e "--consul \t Number of Consul nodes to expect -C(3)"
echo -e "--s3url \t specify the s3 URL  -S3url (https://s3.amazonaws.com/)"
echo -e "--s3bucket \t specify -s3bucket (your-bucket)"
echo -e "--s3prefix \t specify -s3prefix (prefix/to/key | folder/folder/file)"
}
##################################### Functions

# Call checkos to ensure platform is supported
checkos


## set an initial value
CONSUL=3

# Read the options from cli input
TEMP=`getopt -o h:  --long help,verbose,consul:,s3bucket:,s3url:,s3prefix: -n $0 -- "$@"`
eval set -- "$TEMP"


if [ $# == 1 ] ; then echo "No input provided! type ($0 --help) to see usage help" >&2 ; exit 1 ; fi

# extract options and their arguments into variables.
while true; do
  case "$1" in
    -h | --help)
	usage
	exit 1
	;; 
    -v | --verbose ) 
	echo "[] DEBUG = ON"
	VERBOSE=true; 
	shift 
	;;
    --consul )
	CONSUL="$2"; 
	shift 2 
	;;
    --s3url )
	S3URL="$2"; 
	shift 2 
	;;
    --s3bucket ) 
	S3BUCKET="$2"; 
	shift 2 
	;;
    --s3prefix ) 
	S3PREFIX="$2"; 
	shift 2 
	;;
    -- ) 
	break;;
    *) break ;;
  esac
done

# do something with the variables -- in this case the lamest possible one :-)
if [[ ${VERBOSE} == 'true' ]]; then
echo "consul = $CONSUL"
echo "s3bucket = $S3BUCKET"
echo "S3url = $S3URL"
echo "s3prefix = $S3PREFIX"
fi 