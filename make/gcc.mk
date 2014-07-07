# -*- coding: utf-8-unix -*-

# Copyright (c) 2011-2011 Tadanori TERUYA (tell) <tadanori.teruya@gmail.com>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# @license: The MIT license <http://opensource.org/licenses/MIT>

## Tool settings.

AR = ar rcusv
RANLIB = ranlib

MKDIR = mkdir -p

MAKEDEPEND = makedepend
MAKEDEPENDFLAGS = -mv -Y.

ifeq ($(BIT), 32)
TARGET_ARCH = -m32
else
TARGET_ARCH = -m64
endif

INCLUDE_DIR =

WARN_FLAGS = -Wall -Wextra -Wabi -Wformat=2 -Wcast-qual \
	-Wcast-align -Wwrite-strings -Wfloat-equal \
	-Wpointer-arith -Wconversion
# -Winline
# -Wfatal-errors

DEBUG_FLAGS = -DNDEBUG

## Change debug flags.
ifeq ($(DBG),on)
DEBUG_FLAGS = -UNDEBUG -g3
endif

ifeq ($(GPROF),on)
GPROF_FLAGS = -pg
endif

ifneq ($(OPT),off)
OPT_FLAGS = -O3 \
	--param inline-unit-growth=1000 \
	--param max-inline-insns-single=1000 \
	--param large-function-growth=1000 \
	-fomit-frame-pointer -funroll-loops
endif

LIBS_FLAGS = -lstdc++

## Set GCC settings

CPPFLAGS = $(WARN_FLAGS) \
	$(TARGET_ARCH) \
	$(OPT_FLAGS) \
	$(GPROF_FLAGS) \
	$(DEBUG_FLAGS) \
	$(INCLUDE_DIR)

CXXFLAGS = -std=c++0x -pedantic -fno-operator-names
# -frepo
# -fno-exceptions

LDFLAGS = $(TARGET_ARCH) $(LIBS_FLAGS) $(GPROF_FLAGS)

## Target and dependency settings.

.PHONY: all clean tags check depend check-syntax

%.s: %.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -S -o $@ $<

all:

check-syntax:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -fsyntax-only $(CHK_SOURCES)
