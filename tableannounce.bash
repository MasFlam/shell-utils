
tableannounce()
{
	local message="$1"
	local fgcolor="$2"
	local bgcolor="$3"
	local tabwidth="$4"

	if [ -z "$fgcolor" ]; then
		fgcolor='38;5;254'
	fi
	if [ -z "$bgcolor" ]; then
		bgcolor='48;5;196'
	fi
	if [ -z "$tabwidth" ]; then
		tabwidth=4
	fi

	message=`sed "s/\t/$(for((i=0;i<tabwidth;++i)); do printf ' '; done)/g" <<< "$message"`

	local linelen=`wc --max-line-length <<< "$message"`
	local linecnt=`wc --lines <<< "$message"`

	local xpos=$((COLUMNS / 2 - linelen / 2))
	local ypos=$((LINES / 2 - linecnt / 2))

	local lines=()
	while IFS= read -r line; do
		lines+=("$line")
	done <<< "$message"

	printf '\e[s'


	printf "\e[$((ypos - 1));${xpos}H"
	printf "\e[${bgcolor}m"
	for((i=0;i<linelen+4;++i)); do
		printf ' '
	done
	printf '\e[49m'


	for((i=0;i<linecnt;++i)); do
		printf "\e[$((ypos + i));${xpos}H"
		printf "\e[${fgcolor};${bgcolor}m"
		l="${lines[i]}"
		printf "  $l"
		llen=`wc --chars <<< "$l"`
		for((j=0;j<linelen-llen+3;++j)); do
			printf ' '
		done
		printf '\e[39;49m'
	done


	printf "\e[$((ypos + linecnt));${xpos}H"
	printf "\e[${bgcolor}m"
	for((i=0;i<linelen+4;++i)); do
		printf ' '
	done
	printf '\e[49m'


	printf '\e[u'
}

tableannounce
