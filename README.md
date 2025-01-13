# Double Math

Notes and exercises for A Level H2/3 Mathematics and H2 Further Mathematics.

## Compiling

### Prerequisites

To compile `DoubleMath.tex`, ensure that you have $\LaTeX$ installed on your local machine. Additionally, download the [`asdia.sty` package](https://github.com/asdia0/asdia.sty). Follow the [installation instructions](https://github.com/asdia0/asdia.sty/blob/main/README.md#installation) provided in the repository to set it up correctly.

### Steps

1. Clone this repository to your local machine. To minimize the size of the `.git` folder, it’s recommended to use the `--depth 1` flag:
```bash
git clone --depth 1 git@github.com:asdia0/DoubleMath.git
```
2. Create a folder called `figures` in the root directory. This is where TikZ-generated figures will be stored.
3. Run the following command to compile `DoubleMath.tex`:
```bash
pdflatex -synctex=1 -interaction=nonstopmode -file-line-error --shell-escape DoubleMath.tex
```
Note that the first compilation may take some time, as it will generate all TikZ figures in the document. For subsequent compilations, you can omit the `--shell-escape` flag unless you’ve modified the TikZ code.