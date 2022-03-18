#!/bin/bash
for i in test_ok/*;do
    cat $i | ./calc
    echo "$?-0"
done