#!/usr/bin/env bash

emacs --batch -l org --eval "(org-babel-tangle-file \"./emacs.org\")"
