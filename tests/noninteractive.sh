#!/bin/bash

HERE=$(dirname $0)
DSH=$HERE/../dsh

echo 1..1

$DSH -- echo ok </dev/null >$0.out 2>/dev/null

if test $(cat $0.out) != 'ok'; then
  echo -n not
fi
echo ok - noninteractive shell command run

rm $0.out
