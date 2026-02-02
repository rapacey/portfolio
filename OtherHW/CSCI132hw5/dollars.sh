#!/bin/bash

#CS 132 - Practical Unix - CUNY
#Rob Pacey
#February 2, 2026

#Filter for valid currency: $1.00+, cents required, commas required over $999.99

grep -E '\$[1-9][0-9]{0,2}(,[0-9]{3})*\.[0-9]{2}(\b|[[:space:]]|$)'
