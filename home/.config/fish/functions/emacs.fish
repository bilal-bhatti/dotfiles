function emacs -d "Launch Emacs.app or emacsclient if server is running"
	if pgrep -f Emacs > /dev/null
		emacsclient -nc $argv
	else
		open -a Emacs $argv
	end
end

