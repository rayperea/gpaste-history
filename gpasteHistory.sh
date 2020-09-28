#!/usr/bin/sh

SOURCE="${BASH_SOURCE[0]}"

# Resolve the folder where the config file should be
# Credit to Dave Dopson's answer on Stack overflow at https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]
do
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	# if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [ -e "${DIR}/config.sh" ]
then
	. "${DIR}/config.sh"
fi
if [ -e "${DIR}/localConfig.sh" ]
then
	. "${DIR}/localConfig.sh"
fi

# Determine which history entry we are interested in
at=0
if [ -f ~/.gpasteHistoryAt ]
then
	at=$(cat ~/.gpasteHistoryAt)
fi
direction="backward"
if [ ! -z "$1" ]
then
	direction="$1"
fi

if [ "$direction" == "forward" ]
then
	((at=at-1))
else
	((at=at+1))
fi

if [ "$at" -lt 0 ]
then
	at=0
fi

# Store the history entry position so that we can easily move backward and forward through the history
echo "$at" > ~/.gpasteHistoryAt
next=$(gpaste-client get "$at")
if [ "${#next}" -gt "$maxDisplayCharacters" ]
then
	next="${next:0:${maxDisplayCharacters}}..."
fi

# Display a dialog to the user so that the entry can be copied to the clipboard
parsed=$(echo "$next" | recode ascii..html)
killall zenity > /dev/null 2>&1
pos="$at"
if [ "$pos" -eq 0 ]
then
	pos="Current"
else
	pos="History Position ${pos}"
fi

zenity --info --width="$dialogWidth" --height="$dialogHeight" --title="${pos}" --ok-label="Copy to clipboard" --text="$parsed"
status=$?

if [ "$status" -eq 0 ]
then
	gpaste-client select "$at"
	rm -f ~/.gpasteHistoryAt
fi
if [ "$status" -eq 1 ]
then
	rm -f ~/.gpasteHistoryAt
fi
