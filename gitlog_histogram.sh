#!/usr/bin/env bash
git log | awk '/Date: /{ printf("%s %s %s\n", $6, $3, $4) }' | gawk -f ~/bin/date-histogram.awk
