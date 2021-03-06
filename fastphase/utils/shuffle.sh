#!/bin/bash

# seeding adopted from https://stackoverflow.com/a/41962458/7820599
get_seeded_random()
{
  seed="$1";
  openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
    </dev/zero 2>/dev/null;
}

seed=0;

# Option parsing adopted from https://stackoverflow.com/a/14203146
REST=""
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
	-s)
	    seed="$2"
	    shift
	    shift
	    ;;
	-n)
	    COUNT="$2"
	    shift
	    shift
	    ;;
	*)    # unknown option
	    REST="$REST $1"
	    shift # past argument
	    ;;
    esac
done

if [ -z "$COUNT" ]; then
  shuf --random-source=<(get_seeded_random $seed) $REST
else
  shuf -n $COUNT --random-source=<(get_seeded_random $seed) $REST
fi
