#!/usr/bin/env bash

 < ~/Org/Lists.riot perl -ne 'print if (/^Subject:/ or not /^[\w-]*:/ and not /^From background/) '|perl -lpe '$_="\n\n\n\n$_\n========" and s/\b(\w)/\U$1/g if /^Subject:/' | enscript -2rBhp blar.ps

