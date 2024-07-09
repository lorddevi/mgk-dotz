#!/usr/bin/env fish

# Author: Lord_Devi
# Desc: Generates a short random string. Useful for inserting random
# strings into filenames.

function rands
	set -l LENGTH 12
	tr -dc A-Za-z0-9 </dev/urandom | head -c $LENGTH
end
