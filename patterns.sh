#!/usr/bin/bash

declare -r PATH_TEMPLATE='^((/)?([a-zA-Z]+)(/[a-zA-Z]+/?)?$|/)'

INTDEC_PATTERN="^([0-9]{1,3})(\.[0-9]{1,2})?$"
INTEGER_PATTERN="^[0-9]{1,3}$"
PATH_PATTERN="^(\/|\.|(\.\/))?[a-zA-Z-]+$"
