#!/usr/bin/env fish

function note
	set NOTE_BASE /Users/(whoami)"/Google Drive"
	vim $NOTE_BASE/(cap $argv)/notes-(date +%d.%m.%y).txt
end
