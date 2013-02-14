#!/bin/bash

# install opam
git clone --depth 1 http://github.com/OCamlPro/opam.git
cd opam
./configure --prefix=$HOME/opt
make
make install

opam init
eval `opam config env`

# install ocaml 4.00.1+annot
time opam install 4.00.1+annot
eval `opam config env`

# install ocamlspot
time opam install spotinstall
time opam install ocamlspot

# install camlp5
time opam install camlp5
