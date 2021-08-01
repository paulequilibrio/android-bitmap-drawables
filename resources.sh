#!/bin/sh

# Creates alternative Android bitmap drawables for different densities.
# Base images:
#  icon.png (512x512px)
#  splash.png (1200x1200px centralized picture on a 2208x2208px frame)

print_fail () { printf "\e[0;31m[ FAIL ] %s\n\e[0m" "$1"; }
print_info () { printf "\e[0;36m[ INFO ] %s\n\e[0m" "$1"; }
print_ok ()   { printf "\e[0;32m[  OK  ] %s\n\e[0m" "$1"; }

SCRIPT_ABS_PATH="$(realpath "$0")"
SCRIPT_ABS_DIR="$(dirname "$SCRIPT_ABS_PATH")"
BASE_DIR="$1"

if [ -d "$BASE_DIR" ]; then
  BASE_ABS_DIR="$(realpath "$BASE_DIR")"
else
  BASE_ABS_DIR="$(realpath .)"
fi

OUTPUT_ABS_DIR="${BASE_ABS_DIR}/res"
BASE_ABS_ICON="${BASE_ABS_DIR}/icon.png"
BASE_ABS_SPLASH="${BASE_ABS_DIR}/splash.png"


check_file () {
  if [ ! -f "$1" ]; then
    print_fail "not found: $1" && exit 1
  else
    DIMENSIONS=$(identify "$1" | grep -oP '\d+x\d+(?=\+)')
    if [ "$DIMENSIONS" != "$2" ]; then
      print_fail "wrong dimensions ($DIMENSIONS != $2): $1" && exit 2
    fi
  fi
}


create_mipmap () {
  name="$1"
  size="$2"
  dirname="${OUTPUT_ABS_DIR}/mipmap-${name}"
  mkdir -p "$dirname"
  if convert "$BASE_ABS_ICON" -resize "$size" "${dirname}/ic_launcher.png" 2> /dev/null ; then
    print_ok "$name"
  else
    print_fail "$name"
  fi
}


create_mipmap_v26 () {
  name="$1"
  size="$2"
  bg_size="$3x$3"
  base="${SCRIPT_ABS_DIR}/base"
  back="ic_launcher_background.png"
  fore="ic_launcher_foreground.png"
  dirname="${OUTPUT_ABS_DIR}/mipmap-${name}-v26"
  mkdir -p "$dirname"
  cp "${base}/ic_launcher.xml" "${dirname}/ic_launcher.xml"
  temp="${dirname}/temp.png"

  if [ "$3" -lt 100 ]; then
    convert "$BASE_ABS_ICON" -resize "48x48" "$temp"
    base_back="${base}/t_${back}"
    convert "${base}/${back}" -resize "${bg_size}" "${dirname}/$back"
  else
    convert "$BASE_ABS_ICON" -resize "192x192" "$temp"
    base_back="${base}/x_${back}"
    convert "$base_back" -resize "${bg_size}" "${dirname}/$back"
  fi

  if composite -gravity center "$temp" "$base_back" "${dirname}/$fore" \
  && convert "${dirname}/$fore" -resize "${bg_size}" "${dirname}/$fore"
  then
    print_ok "${name}-v26"
  else
    print_fail "${name}-v26"
  fi

  rm "$temp"
}


create_ic_launcher () {
  name="$1"
  case $name in
       ldpi ) size='36x36'   ; bg_size='36' ;;
       mdpi ) size='48x48'   ; bg_size='48' ;;
       hdpi ) size='72x72'   ; bg_size='72' ;;
      xhdpi ) size='96x96'   ; bg_size='216' ;;
     xxhdpi ) size='144x144' ; bg_size='324' ;;
    xxxhdpi ) size='192x192' ; bg_size='432' ;;
  esac

  create_mipmap "$name" "$size"
  create_mipmap_v26  "$name" "$size" "$bg_size"
}


get_drawable_path () {
  orientation="$1"
  name="$2"
  dirname="${OUTPUT_ABS_DIR}/drawable-${orientation}-${name}"
  mkdir -p "$dirname"
  echo "${dirname}/screen.png"
}

create_splash () {
  name="$1"
  case $name in
       ldpi )  width=320;  height=200 ;;
       mdpi )  width=480;  height=320 ;;
       hdpi )  width=800;  height=480 ;;
      xhdpi ) width=1280;  height=720 ;;
     xxhdpi ) width=1600;  height=960 ;;
    xxxhdpi ) width=1920; height=1280 ;;
  esac

  percentage=$(echo "scale=2; 100*${width}/2208" | bc)
  offset=$(( (width-height)/2 ))
  land="$(get_drawable_path 'land' "$name")"
  port="$(get_drawable_path 'port' "$name")"

  if convert "$BASE_ABS_SPLASH" -resize "${percentage}%" -crop "${width}x${height}+0+${offset}" "$land" 2> /dev/null
  then
    print_ok "$name landscape"
  else
    print_fail "$name landscape"
  fi

  if convert "$BASE_ABS_SPLASH" -resize "${percentage}%" -crop "${height}x${width}+${offset}+0" "$port" 2> /dev/null
  then
    print_ok "$name portrait"
  else
    print_fail "$name portrait"
  fi
}


check_file "$BASE_ABS_ICON" '512x512' && print_info 'Generating icon...'
create_ic_launcher ldpi
create_ic_launcher mdpi
create_ic_launcher hdpi
create_ic_launcher xhdpi
create_ic_launcher xxhdpi
create_ic_launcher xxxhdpi

check_file "$BASE_ABS_SPLASH" '2208x2208' && print_info 'Generating splash...'
create_splash ldpi
create_splash mdpi
create_splash hdpi
create_splash xhdpi
create_splash xxhdpi
create_splash xxxhdpi

print_info "Done"
