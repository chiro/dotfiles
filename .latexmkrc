#!/usr/bin/env perl
$latex = 'platex -synctex=1 -halt-on-error';
$latex_silent = 'platex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3; # generates pdf via dvipdfmx

$pvc_view_file_via_temporary = 0;

if ($^O eq 'darwin') {
    $pdf_previewer = "open -ga ~/Applications/Skim.app";
} elsif ($^O eq 'linux') {
    $pdf_previewer = 'evince %O %S';
}
