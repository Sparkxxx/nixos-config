#!/bin/sh

nix shell nixpkgs#mosquito --command mosquito_sub -h nuc -p 1883 -t '#' -v
