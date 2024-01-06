#!/bin/env zsh

set -e

vol=$(amixer sget Master | awk -F"[][]" '/Mono:/ {print $2}')

echo "Vol: $vol"
