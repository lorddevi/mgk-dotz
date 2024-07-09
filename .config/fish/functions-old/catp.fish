# ~/.config/fish/functions/catp.fish
# Author: Lord_Devi
# Desc: Fish function to be a really quick 'cat picture'
# command. Using 'pixcat' for Kitty.
if type -qf pixcat
    function catp
	for i in $argv
	    echo "Displaying Image: $i"
	    command pixcat r -W 800 -H 600 --align left $i
	end
    end
end
