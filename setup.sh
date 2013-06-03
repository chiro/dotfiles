#!/bin/sh

if [ ! -f "$HOME/.emacs.d/elisp/init-loader.el" ]; then
    echo "Install init-loader"
    wget https://raw.github.com/emacs-jp/init-loader/master/init-loader.el init-loader.el
    mkdir -p ~/.emacs.d/elisp
    mv init-loader.el ~/.emacs.d/elisp/init-loader.el
fi

# install slime
if [ ! -d "$HOME/.emacs.d/elisp/slime" ]; then
    echo "Install slime!"
    wget http://common-lisp.net/project/slime/snapshots/slime-current.tgz
    tar zxf slime-current.tgz
    rm slime-current.tgz
    mv slime* ~/.emacs.d/elisp/slime
fi

# install proof-general
if [ ! -d "$HOME/.emacs.d/elisp/ProofGeneral-4.3pre130522" ]; then
    echo "Install ProofGeneral"
    wget http://proofgeneral.inf.ed.ac.uk/releases/ProofGeneral-4.3pre130522.tgz
    tar zxf ProofGeneral-4.3pre130522.tgz
    rm ProofGeneral-4.3pre130522.tgz
    mv ProofGeneral $HOME/.emacs.d/elisp/ProofGeneral
    mv ProofGeneral-4.3pre130522 $HOME/.emacs.d/elisp/ProofGeneral-4.3pre130522
fi
