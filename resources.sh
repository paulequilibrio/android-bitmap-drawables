#!/bin/sh

# Creates alternative Android bitmap drawables for different densities.
# Base images:
#  icon.png (512x512px)
#  splash.png (1200x1200px centralized picture on a 2208x2208px frame)

function print_fail() { printf "\e[0;31m[ FAIL ] %s\n\e[0m" "$1"; }
function print_info() { printf "\e[0;36m[ INFO ] %s\n\e[0m" "$1"; }
function print_ok()   { printf "\e[0;32m[  OK  ] %s\n\e[0m" "$1"; }

[[ $1 == "" ]] && ABSPATH="$(realpath .)" || ABSPATH="$(cd $1; pwd)"

BASE_ICON="${ABSPATH}/icon.png"
BASE_SPLASH="${ABSPATH}/splash.png"
ICONS_PATH="${ABSPATH}/android/icon"
SPLASHES_PATH="${ABSPATH}/android/splash"

mkdir -p $ICONS_PATH
mkdir -p $SPLASHES_PATH


function check_file() {
  if [ ! -f $1 ]; then
    print_fail "not found: $1" && exit 1
  else
    DIMENSIONS=$(identify $1 | grep -oP '\d+x\d+(?=\+)')
    if [ "$DIMENSIONS" != "$2" ]; then
      print_fail "wrong dimensions ($DIMENSIONS != $2): $1" && exit 2
    fi
  fi
}


function create_icon() {
  case $1 in
       ldpi )  SIZE='36x36'  ;;
       mdpi )  SIZE='48x48'  ;;
       hdpi )  SIZE='72x72'  ;;
      xhdpi )  SIZE='96x96'  ;;
     xxhdpi ) SIZE='144x144' ;;
    xxxhdpi ) SIZE='192x192' ;;
  esac

  convert $BASE_ICON -resize ${SIZE} ${ICONS_PATH}/drawable-$1-icon.png 2> /dev/null \
  && print_ok "$1" || print_fail "$1"
}


function create_splash() {
  case $1 in
       ldpi )  WIDTH=320;  HEIGHT=240 ;;
       mdpi )  WIDTH=480;  HEIGHT=320 ;;
       hdpi )  WIDTH=800;  HEIGHT=480 ;;
      xhdpi ) WIDTH=1280;  HEIGHT=720 ;;
     xxhdpi ) WIDTH=1600;  HEIGHT=960 ;;
    xxxhdpi ) WIDTH=1920; HEIGHT=1280 ;;
  esac

  PERCENTAGE=$(echo "scale=2; 100*${WIDTH}/2208" | bc)
  OFFSET=$(( ($WIDTH-$HEIGHT)/2 ))

  convert $BASE_SPLASH -resize ${PERCENTAGE}% -crop "${WIDTH}x${HEIGHT}+0+${OFFSET}" ${SPLASHES_PATH}/drawable-land-$1-screen.png 2> /dev/null \
  && print_ok "$1 landscape" || print_fail "$1 landscape"

  convert $BASE_SPLASH -resize ${PERCENTAGE}% -crop "${HEIGHT}x${WIDTH}+${OFFSET}+0" ${SPLASHES_PATH}/drawable-port-$1-screen.png 2> /dev/null \
  && print_ok "$1 portrait"  || print_fail "$1 portrait"
}


check_file $BASE_ICON '512x512' && print_info 'Generating icon...'
create_icon ldpi
create_icon mdpi
create_icon hdpi
create_icon xhdpi
create_icon xxhdpi
create_icon xxxhdpi

check_file $BASE_SPLASH '2208x2208' && print_info 'Generating splash...'
create_splash ldpi
create_splash mdpi
create_splash hdpi
create_splash xhdpi
create_splash xxhdpi
create_splash xxxhdpi

print_info "Done"
