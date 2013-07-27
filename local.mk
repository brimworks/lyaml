# Non-recursive Make rules.
#
# Copyright (C) 2013 Gary V. Vaughan
# Written by Gary V. Vaughan, 2013
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


## ------------ ##
## Environment. ##
## ------------ ##

lyaml_cpath = $(abs_builddir)/ext/lyaml/$(objdir)/?$(shrext)
LUA_ENV     = LUA_CPATH="$(lyaml_cpath);$(LUA_CPATH)"


## ---------- ##
## Bootstrap. ##
## ---------- ##

old_NEWS_hash   = 6ce65f1c2b9efaf308946bbbca9d5b89

include specs/specs.mk


## ------------- ##
## Declarations. ##
## ------------- ##

lib_LTLIBRARIES += ext/lyaml/lyaml.la

ext_lyaml_lyaml_la_SOURCES  = \
		ext/lyaml/lyaml.c	\
		ext/lyaml/parser.c	\
		$(NOTHING_ELSE)

ext_lyaml_lyaml_la_LDFLAGS  = -module -avoid-version
ext_lyaml_lyaml_la_CPPFLAGS = $(LUA_INCLUDE) $(YAML_INCLUDE)

EXTRA_DIST      += ext/lyaml/lua52compat.h

# Point mkrockspecs at the in-tree lyaml module.
MKROCKSPECS_ENV = $(LUA_ENV)

# Make sure lyaml is built before calling mkrockspecs.
$(package_rockspec) $(scm_rockspec): $(lib_LTLIBRARIES)