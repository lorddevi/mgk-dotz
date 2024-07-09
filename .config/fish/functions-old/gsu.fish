# ~/.config/fish/functions/gsu.fish
# Screenshotting tool which allows for screenshotting of seperate screens more easily than others.

if type -qf gsu
    function gsu1
	command gsu \
	    -d 1 \
	    ~/pix/scrots/$argv.jpg
    end
    function gsu2
	command gsu \
	    -d 2 \
	    ~/pix/scrots/$argv.jpg
    end
    function gsu3
	command gsu \
	    -d 3 \
	    ~/pix/scrots/$argv.jpg
    end
    function gsu4
	command gsu \
	    -d 4 \
	    ~/pix/scrots/$argv.jpg
    end
    function gsu5
	command gsu \
	    -d 5 \
	    ~/pix/scrots/$argv.jpg
    end
    function gsu6
	command gsu \
	    -d 6 \
	    ~/pix/scrots/$argv.jpg
    end
end
