#!/bin/bash

mkdir -p gen/runners
mkdir -p gen/main

tests=$(find * -maxdepth 1 -name "test_*" -type f | sed 's/\.[^.]*$//')

#use ctags to generate list of tests to be run by RUN_TEST unity macro
#this works by filtering all functions defined with TEST_CASE macro

for test in $tests
do
    printf '%s\n\n' '#pragma once' > gen/runners/runner_${test}.h

    find . -type f -name ''${test}'.cpp' -exec ctags -x --c-kinds=f {} ';' > gen/runners/table
    grep -oP '(?<=TEST_CASE\()(.*)(?=\))' gen/runners/table | sed 's/$/);/' | sed 's/^/RUN_TEST(/' > gen/runners/runner_${test}.cpp
    grep -oP '(?<=TEST_CASE\()(.*)(?=\))' gen/runners/table | sed 's/$/();/' | sed 's/^/void /' >> gen/runners/runner_${test}.h

    printf '%s\n' '#include "gen/runners/runner_'${test}'.h"' > gen/main/main_${test}.cpp
    printf '%s\n\n' '#include "unity/src/unity.h"' >> gen/main/main_${test}.cpp
    printf '%s\n' 'void TESTS_EXECUTE() {' >> gen/main/main_${test}.cpp
    printf '%s\n' '#include "gen/runners/runner_'${test}'.cpp"' >> gen/main/main_${test}.cpp
    printf '%s\n\n' '}' >> gen/main/main_${test}.cpp
    printf '%s' '#include "unity/main.cpp"' >> gen/main/main_${test}.cpp
done