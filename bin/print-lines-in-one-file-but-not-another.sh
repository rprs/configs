#!/bin/bash
# Grabs two files and shows lines in file1 but not on file2

function printUsage () {
  echo 'Usage:'
  echo '  sh showLinesInListOneButNotInListTwo.sh file1 file2'
  echo ''
  exit
}

function VerifyFile () {
  if [[ $# -ne 1 ]]
  then
    echo Error: VerifyFile receives only one argument, was given $#
  fi
  if [[ ! -e $1 ]]
  then
    echo Error: File does not exist: $1
  fi
  if [[ ! -s $1 ]]
  then
    echo Error: Empty file: $1
  fi
  if [[ -d $1 ]]
  then
    echo Error: file: $1
  fi
}

# Checking that we have right number of parameters.
if [[ $# -ne 2 ]]
then
  echo Error: Wrong number of arguments. Expected: 2, got: $#
  printUsage
fi

# Retrieving files 
VerifyFile $1
file1=$1

VerifyFile $2
file1=$2

# Now that we are sure file exists, we let grep do all the magic.
# -f file : this means to brab the pattern we are looking for from this file. Look for all of the lines.
# -v      : print lines that do not match.
# -F      : interpret pattern as fixed string, not a regexp.
# -x      : match the whole line.
grep -f $1 -vFx $2
