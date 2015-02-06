#!/usr/bin/env bash

source ~/.bashrc

if [[ $SSH_ORIGINAL_COMMAND != "" ]]; then
    $SSH_ORIGINAL_COMMAND
elif [[ $SSH2_ORIGINAL_COMMAND != "" ]]; then
    $SSH2_ORIGINAL_COMMAND
fi
