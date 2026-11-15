# Build settings shared by everyone. Running `latexmk` in the project folder
# builds main.tex to main.pdf. LaTeX Workshop in VS Code also picks this up.
@default_files = ('main.tex');
$pdf_mode = 1;
$pdflatex = 'pdflatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
