# ~/.config/fish/functions/fixperms.fish
# Author: Lord_Devi
# Desc: Function for helping to quickly set the perms on both files
# and directories in a home directory.
#
# Directories = 755 (drwxr-xr-x)
# Files = 644 (.rw-r--r--)
function fixperms
	 find $argv -type d -exec chmod 755 {} \;
	 find $argv -type f -exec chmod 644 {} \;
end
