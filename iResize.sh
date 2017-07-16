#!/bin/bash

fname=$(pwd) #get current directory

if [[ ! $1 ]]; then
echo "Please supply a divisor"
exit 0
fi

mkdir resized

for f in *
do

if [ -f "$f" ] #test if file
then
    filename=$(basename $f | sed 's/$f././g')
    echo $filename

    H=$(sips -g pixelHeight "$f" | grep 'pixelHeight' | cut -d: -f2)
    W=$(sips -g pixelWidth "$f" | grep 'pixelWidth' | cut -d: -f2)


#math with bc because bash can only handle whole numbers
W=$(bc -l <<< "scale=0; $W / $1")
H=$(bc -l <<< "scale=0; $H / $1")

echo "New Size:$H"

sips --resampleHeight "$H" "$f" --out "resized" >/dev/null
fi
done
#change timestamp to make iDevice happy
#must have exiftool installed
#cd resized
#tsfixer
