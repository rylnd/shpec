# shpec Changelog

## 0.2.2 Unreleased

## 0.2.1 (May 11 2015)
  * shpec now exits on an unbalanced `end` statement

## 0.2.0 (Apr 23 2015)
  * POSIX support - shpec now works on bash, dash, and ksh93

## 0.1.2 (Feb 16 2014)
  * Add Antigen package manager support

## 0.1.1 (Dec 17 2014)
  * Add no_match matcher
  * Refactor indented printing

## 0.1.0 (Nov 20 2014)

 * Add end function

## 0.0.10 (Jul 16 2014)

 * Allow comparison of strings containing quotes

## 0.0.9 (Mar 7 2013)

 * Set SHPEC_ROOT without using find

## 0.0.8 (Mar 6 2013)

 * Pass in SHPEC_ROOT as an env variable
 * Gt lt bugfix

## 0.0.7 (Mar 3 2013)

 * Add --version command line option
 * Add default TMPDIR

## 0.0.6 (Feb 27 2013)

 * Custom Matchers

## 0.0.5 (Feb 23 2013)

 * Remove sudo from installer

## 0.0.4 (Feb 22, 2013)

 * Add function to stub commands
 * Allow a function body to be passed to stub_command
 * Equality matcher handles newlines

## 0.0.3 (Feb 8, 2013)

  * Cleanup Makefile for Homebrew
  * Color final summary output
  * Less hacky indenting
  * errors_to_stdout:
  * Shpec files use <name>_shpec.sh naming convention
  * Install one liner
  * Moar assertions
  * Add tests for gt lt asserts
  * Add time and summary
  * Add file matchers
  * Add 'unequal' and 'prsent' matchers
  * Rename file suffix from spec to shpec
  * Test exit codes
