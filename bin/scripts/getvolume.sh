#!/bin/env bash

source_id=57

result=$(wpctl get-volume $source_id 2> /dev/null | awk '{print $2 * 100}')

echo $result
