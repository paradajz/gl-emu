vpath modules/%.c ../
vpath src/%.cpp ../

TEST_FRAMEWORK_SOURCES := \
modules/unity/src/unity.c

#common include dirs
INCLUDE_DIRS := \
-I"../" \
-I"./" \
-I"../src" \
-I"../modules/" \
-I"./unity/"