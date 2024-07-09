# ~/.config/fish/functions/blkpng2jpg.fish
# Author: Lord_Devi
# Desc: Bulk convert all png files to jpg.  Saves on space when
# working with papez.  (Will remove transparencies.)
if type -qf parallel and type -qf convert
    function blkpng2jpg
	parallel convert '{}' '{.}.jpg' ::: *.png
    end
end
