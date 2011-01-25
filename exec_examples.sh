#!/bin/bash

# Redirect stdout to file 'foo'. Save stdout in fd 5.
exec 5>&1 >foo
echo "Hi there"

# Reconnect stdout to terminal and close 5.
exec 1>&5 5>&-

# Open 6 to read from foo.
exec 6<foo

lsof -p $$

read line <&6

echo $line


