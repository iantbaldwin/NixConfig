#!/bin/bash
#
# Weather
# =======
#
# By Jezen Thomas <jezen@jezenthomas.com>
#
# This script sends a couple of requests over the network to retrieve
# approximate location data, and the current weather for that location. This is
# useful if for example you want to display the current weather in your tmux
# status bar.

# There are three things you will need to do before using this script.
#
# 1. Install jq with your package manager of choice (homebrew, apt-get, etc.)
# 2. Sign up for a free account with OpenWeatherMap to grab your API key
# 3. Add your OpenWeatherMap API key where it says API_KEY

# OPENWEATHERMAP API KEY (place yours here)
API_KEY="f4ac6848cbd08a675b9820b94ee197eb"

set -e
clear_icon() {
	if (( $1 < $2 || $3 < $1 )); then
		echo ☾
	else
		echo ☀︎
	fi
}

day_or_night() {
	if (( $1 >= $2 || $1 <= $3 )); then
		echo 🌙
	else
		echo ☀️
	fi
}

# Not all icons for weather symbols have been added yet. If the weather
# category is not matched in this case statement, the command output will
# include the category ID. You can add the appropriate emoji as you go along.
#
# Weather data reference: http://openweathermap.org/weather-conditions

weather_icon() {
	if (( 200 <= $1 && $1 < 300 )); then
		echo ⛈
	elif (( 300 <= $1 && $1 < 400 )); then
		echo 🌦
	elif (( 500 <= $1 && $1 < 600 )); then
		echo 🌧
	elif (( 600 <= $1 && $1 < 700 )); then
		echo ❄️
	elif (( 700 <= $1 && $1 < 800 )); then
		case $1 in
			701) echo "mist"
				;;
			711) echo "smoke"
				;;
			721) echo "haze"
				;;
			731) echo "sand, dust whirls"
				;;
			741) echo 🌫
				;;
			751) echo "sand"
				;;
			761) echo "dust"
				;;
			762) echo "volcanic ash"
				;;
			771) echo 💨
				;;
			781) echo 🌪
				;;
		esac
	elif (( $1 == 800 )); then
		echo $(day_or_night $(date +%s) $2 $3)
	elif (( 800 < $1 && $1 < 900 )); then
		case $1 in
			801) echo 🌤
				;;
			802) echo ⛅️
				;;
			803) echo 🌥
				;;
			804) echo ☁️ 
				;;
		esac
	elif (( 900 <= $1 && $1 < 1000)); then
		case $1 in
			900) echo 🌪
				;;
			901) echo 🌊
				;;
			902) echo 🌊
				;;
			903) echo 🌡
				;;
			904) echo 🌡
				;;
			905) echo 💨
				;;
			906) echo "hail"
				;;
			951) echo $(day_or_night $(date +%s) $2 $3)
				;;
			952) echo 💨
				;;
			953) echo 💨
				;;
			954) echo 💨
				;;
			955) echo 💨
				;;
			956) echo 💨
				;;
			957) echo 💨
				;;
			958) echo 💨
				;;
			959) echo 💨
				;;
			960) echo ⛈
				;;
			961) echo ⛈
				;;
			962) echo 🌊
				;;
		esac
	fi
}

while true; do
	LOCATION=$(curl --silent http://ip-api.com/csv)
	CITY=$(echo "$LOCATION" | cut -d , -f 6)
	LAT=$(echo "$LOCATION" | cut -d , -f 8)
	LON=$(echo "$LOCATION" | cut -d , -f 9)

	WEATHER=$(curl --silent http://api.openweathermap.org/data/2.5/weather\?lat="$LAT"\&lon="$LON"\&APPID="$API_KEY"\&units=imperial)

	CATEGORY=$(echo "$WEATHER" | jq .weather[0].id)
	TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)°F"
	SUNRISE=$(echo "$WEATHER" | jq .sys.sunrise)
	SUNSET=$(echo "$WEATHER" | jq .sys.sunset)
	ICON=$(weather_icon "$CATEGORY" $SUNRISE $SUNSET)

	printf "  $TEMP $ICON" > ~/.cache/weather_status
	sleep 60
done
