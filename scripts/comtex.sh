#!/bin/bash
dir=$(pwd)
cd $dir

simple_compile()
{
    pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
}

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
fi

green=$(tput setaf 2)            

while getopts "bs" option
do
    case $option in 
        b)
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex &&
            echo -e "\n\n\n\n\t\t\t Compile BIB \n\n\n\n"
            bibtex out-ruco/*.aux &&
            echo -e "\n\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
            ;;
        s)
            echo -e "\t\t\t\n\nYou select Makeindex option compile\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex &&
            makeglossaries -s out-ruco/*.ist -t out-ruco/*.glg -o out-ruco/*.gls out-ruco/*.glo&&
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
            echo -e "\n\n\t\t\t\t\t${green}Finish\n\n"
            ;;
        *)  
            simple_compile
            exit;;
    esac
done



            