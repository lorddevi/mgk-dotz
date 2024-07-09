# ~/.config/fish/functions/yt-dl.fish
# Author: Lord_Devi
# Desc: Functions for downloading entire youtube channels and such.
# Needs work.

function f_yt-dl
	youtube-dl "$argv[1]" \
		--download-archive ~/.config/youtube-dl/youtube-dl-seen.conf \
		--prefer-free-formats \
		--playlist-end $argv[2] \
		--write-description \
		--output "~/vidz/yt-dl/%(uploader)s/%(upload_date)s - %(title)s.%(ext)s"
end

function f_yt-dl-user
	f_yt-dl "https://www.youtube.com/user/$argv[1]" 10
end

function f_yt-dl-channel
	f_yt-dl "https://www.youtube.com/channel/$argv[1]" 10
end

function f_yt-dl-playlist
	f_yt-dl "https://www.youtube.com/playlist?list=$argv[1]"
end

