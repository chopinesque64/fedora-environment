#!/bin/bash

# Install Emacs to bootstrap our literate config
sudo dnf install -y emacs

# Tangle the configuration and execute it
emacs --batch -l org fedora-environment.org \
      --eval="(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))" \
      --eval="(setq org-confirm-babel-evaluate nil)" \
      --eval="(org-babel-execute-buffer)"
