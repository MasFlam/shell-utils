
toprite()
{
	local str="$1"
	if [ -z "$str" ]; then
		str="$(date '+%Y-%m-%d %H:%M:%S')"
	fi
	local slen=${#str}
	local col=$((COLUMNS - slen + 1))
	echo -ne "\e[s\e[;${col}H\e[91m${str}\e[m\e[u"
}

toprite
