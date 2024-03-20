from sympy import sympify
from sympy import reduce_inequalities
from sympy.abc import x
from sympy.printing.pretty import pretty
from fractions import Fraction

class Range:
    def __init__(self, lowerArrow, upperArrow, lowerBound, upperBound):        
        self.lowerArrow = lowerArrow
        self.upperArrow = upperArrow
        self.lowerBound = lowerBound
        self.upperBound = upperBound

    def __str__(self):
        return str((self.lowerArrow, self.upperArrow, self.lowerBound, self.upperBound))

def SampleValue(lowerBound, upperBound):
    sample = 0
    if None not in [lowerBound, upperBound]:
        sample = 0.5 * (lowerBound + upperBound)
    elif lowerBound is None:
        sample = upperBound - 1
    else:
        sample = lowerBound + 1

    return sample

def FormatExpression(expression):
    replacements = {
        " " : "",
        "+" : " + ",
        "-" : " - ",
        "*" : " * ",
        "/" : " / ",
        "^" : " ** ",
        "<" : " < ",
        ">" : " > ",
        "<=" : " <= ",
        ">=" : " >= ",
    }

    for key in replacements:
        expression = expression.replace(key, replacements[key])

    return expression

def SolutionToRanges(solvedInequality):
    ranges = []

    for solution in str(solvedInequality).split(" ∪ "):
        # Solution is a single value
        if solution[0] == "{":
            value = int(TrimEdges(solution))
            ranges.append(Range("*", "*", value, value))
            continue

        # Solution is a set
        lowerArrow = solution[0]
        upperArrow = solution[-1]

        bounds = [None if "∞" in str(x) else FractionToDecimal(x) for x in TrimEdges(solution).split(", ")]

        lowerArrow = BracketToArrow(lowerArrow, bounds[0])
        upperArrow = BracketToArrow(upperArrow, bounds[1])

        ranges.append(Range(lowerArrow, upperArrow, bounds[0], bounds[1]))

    return ranges

def TrimEdges(string):
    return (string[1:])[:-1]

def EvaluateExpression(expression, xvalue):
    value = sympify(expression).evalf(subs={x:xvalue})

    if (value > 0):
        return "+"
    
    if (value < 0):
        return "-"
    
    return ""

def BracketToArrow(bracket, bound):
    if bound is None:
        return ""
    
    if bracket in ["(", ")"]:
        return "o"
    if bracket in ["[", "]"]:
        return "*"
    return ""

def FractionToDecimal(fraction):
    return round(float(Fraction(fraction)), 3)

def GenerateLatex(polynomial, ranges):
    linesFront = ["\\begin{center}", "\t\\begin{tikzpicture}"]
    linesBack = ["\t\\end{tikzpicture}", "\\begin{center}"]
    linesMiddle = []

    bounds = [r.lowerBound for r in ranges if r.lowerBound is not None] + [r.upperBound for r in ranges if r.upperBound is not None]
    bounds = list(set(bounds))

    globalMin = min(bounds)
    globalMax = max(bounds)
    linesMiddle.append(f"\\draw[-latex] ({globalMin - 1},0) -- ({globalMax + 1},0) node[right]{{$x$}}")
    linesMiddle.append(f"\\foreach \\x in {{{','.join([str(bound) for bound in bounds])}}} \\draw[shift={{(\\x,0)}}] (0pt,3pt) -- (0pt,-3pt);")
    linesMiddle.append(f"\\foreach \\x in {{{','.join([str(bound) for bound in bounds])}}} \\draw[shift={{(\\x,-3pt)}}] node[below]  {{$\\x$}}")

    for r in ranges:
        if r.lowerBound != r.upperBound:
            linesMiddle.append(f"\\draw[very thick, {r.lowerArrow}-{r.upperArrow}, color=red] ({globalMin - 1 if r.lowerBound is None else r.lowerBound - 0.12}, 0) -- ({globalMax + 0.9 if r.upperBound is None else r.upperBound + 0.12}, 0);")
        else:
            linesMiddle.append(f"\\path [draw=red, fill=red] ({r.lowerBound},0) circle (3pt);")

    bounds.sort()
    bounds.insert(0, None)
    bounds.append(None)
    print(bounds)
    for i in range(0, len(bounds)-1):
        value = 0
        
        if bounds[i] is None:
            value = 0.5 * ((globalMin - 1) + bounds[i+1])
        elif bounds[i+1] is None:
            value = 0.5 * (bounds[i] + (globalMax + 1))
        else:
            value = 0.5 * (bounds[i] + bounds[i+1])

        linesMiddle.append(f"\\node[anchor=south, align=center] at ({value}, 0) {{${EvaluateExpression(polynomial, value)}$}};")

    lines = linesFront + ["\t\t" + line for line in linesMiddle] + linesBack
    return "\n".join(lines)

if __name__ == "__main__":
    inequality = FormatExpression(input("Inequality: "))
    polynomial = inequality.split(" > ")[0].split(" < ")[0].split(" >= ")[0].split(" <= ")[0]
    intervals = pretty(reduce_inequalities(inequality, []).as_set())
    ranges = SolutionToRanges(intervals)

    print(GenerateLatex(polynomial, ranges))