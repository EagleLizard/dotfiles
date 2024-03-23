#!/bin/bash

default_output_dir=~/Documents/videos

# see: https://stackoverflow.com/a/15672187

checkFile(){
    [[ -s $1 && -f $1 ]] && return 0 || return 1
}

ffcv(){
  local scale="width=1280:height=-2"
  local fps="30"
  local crf="20"
  local preset="slow"

  local input_path="$1"
  local file_name=$(basename -- "$input_path")
  local base_name="${file_name%.*}"
  local output_dir_arg="$2"
  local output_path="${output_dir_arg}/${base_name}.mp4"

  echo ""
  echo "$input_path -vf scale=$scale -r $fps -crf $crf -preset $preset $output_path"

  ffmpeg -i "$input_path" -vf "scale=$scale" -r "$fps" -crf "$crf" -preset "$preset" "$output_path"

  # for arg; do
  #   echo "$arg"
  # done
}


if [[ -z $1 ]]; then
  echo 1>&2 "ffcv expects an argument."
  exit 2
fi

output_flag=
output_dir=
while getopts o: flag
do
  case "${flag}" in
    o) output_flag=${OPTARG};;
  esac
done

output_dir=${output_flag:-$default_output_dir}
# resolved_output_dir=$(readlink -f "$output_dir")
resolved_output_dir=$(realpath "$output_dir")
# resolved_output_dir=$(cd $output_dir; pwd)

echo "resolved_output_dir: $resolved_output_dir"

if [[ ! -d $resolved_output_dir ]]; then
  echo 1>&2 "Error: $output_dir is not a valid directory."
  exit 2
fi

echo "writing output to: $output_dir"
for file in "$@"; do
  if [[ -f $file ]]; then
    ffcv "$file" "$resolved_output_dir"
  fi
done


# if [[ -t 0 ]]; then
#   ffcv "$@"
# else
#   while IFS= read -r a; do
#     checkFile "$a" || continue
#     ffcv "$a"
#   done
# fi
