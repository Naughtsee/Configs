#!/bin/bash

DARK="#FFf36b6b"
LIGHT="#FFff897d"
WHITE="#FFefefef"

workspace(){
	SPACE_NUM=$(bspc query -D -d);
		case "$SPACE_NUM" in
			"1")
				WORKSPACE="■ □ □ □ □";;
			"2")
				WORKSPACE="□ ■ □ □ □";;
			"3")
				WORKSPACE="□ □ ■ □ □";;
			"5")
				WORKSPACE="□ □ □ ■ □";;
			"5")
				WORKSPACE="□ □ □ □ ■";;
		esac
	echo $WORKSPACE
}

chg(){
	echo  $(acpi --battery | awk '{gsub(/,/, "");} {print $4}')
}

bat(){ 
	echo  $(acpi -a | if grep -q "on-line"; then echo ""; else echo "⭫ $(chg)%"; fi)
}

ram(){
	echo  $(free -m | awk '/-/ {print $3}')
}

dat(){
	echo  $(date "+%H:%M  %D")
}

vol(){
	echo  $(amixer | if grep -q "off"; then echo "mute"; else echo $(amixer | awk '/Front Left: Playback/ {print $5}' | sed 's/\[//g;s/\]//g');fi)
}

mus(){
	echo  $(test -z "$(mpc current)" || mpc current)
}

pause(){
	echo  $(mpc | if grep -q "paused"; then echo "(paused)"; fi)
}

while :; do
	echo  "%{B$DARK} %{F$WHITE}♫ %{F$DARK}%{B$LIGHT}%{F}%{B}%{F$WHITE}%{B$LIGHT} $(mus) %{B}%{F}%{F$LIGHT}%{B}%{c}%{B$DARK}%{F$WHITE}%{B}%{F}%{B$DARK} %{F$WHITE}$(workspace) %{B}%{F}%{F$WHITE}%{B$DARK}%{B}%{F}%{c}%{r}%{F$LIGHT}%{F}%{B$LIGHT}%{F$WHITE} $(bat) ram $(ram) vol $(vol)% %{B}%{F}%{F$DARK}%{B$LIGHT}%{F}%{B}%{B$DARK}%{F$WHITE} $(dat) %{B}%{F}"
sleep 1
done