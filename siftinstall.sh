#!/bin/bash

chmod +x ~/sift/sift.sh

sudo mv ~/sift/sift.sh /usr/bin

gcc -o /usr/bin/sift ~/sift/sift.c