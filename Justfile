export concurrently_colors := "blue,green,yellow,magenta,cyan,white"

help:
    just --list

setup:
    raco pkg install pollen

dev args="":
    raco pollen start

build args="":

run:

open cmd="":
    #!/usr/bin/env bash
    url="http://localhost:8080"

    if [[ -n "{{ cmd }}" ]]; then
        {{ cmd }} "$url"
    elif command -v xdg-open &> /dev/null; then
        xdg-open "$url"
    elif command -v open &> /dev/null; then
        open "$url"
    else
        echo "No suitable cmd found. Please install xdg-open or open."
        exit 1
    fi

test:

all:
    concurrently \
    --names "test,lint" \
    --prefix-colors ${concurrently_colors} \
        "just test" \
        "just lint"
