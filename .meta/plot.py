import sympy
from sympy import *
from sympy.functions.elementary.trigonometric import TrigonometricFunction

class Point:
    def __init__(self, x, y):
        self.x = ExpressionToDecimal(x)
        self.y = ExpressionToDecimal(y)

    def __str__(self):
        return str((self.x, self.y))
    
    def __eq__(self, other): 
        if not isinstance(other, Point):
            return NotImplemented

        return self.x == other.x and self.y == other.y
    
    def __hash__(self):
        return hash((self.x, self.y))
    
    def __lt__(self, other):
        return self.x < other.x
    
    def __gt__(self, other):
        return self.x > other.x
    
EquationBundles = []

def GetXIntercepts(expressions):
    points = []

    for expression in expressions:
        points += SolveIntersections(expression, 0, expression)

    return SanitiseList(points)

def GetYIntercepts(expressions):
    return SanitiseList([Point(0, expression.subs("x", 0)) for expression in expressions])

def GetCriticalPoints(expressions):
    points = []

    for expression in expressions:
        ddx = diff(expression, "x")
        points += SolveIntersections(ddx, 0, expression)

    return SanitiseList(points)

def GetIntersections(equations):
    points = []

    for i in range(0, len(equations)):
        for j in range(i + 1, len(equations)):
            e1 = equations[i]
            e2 = equations[j]

            inBundle = False

            for bundle in EquationBundles:
                if e1 in bundle and e2 in bundle:
                    inBundle = True

            if inBundle:
                continue
            
            points += SolveIntersections(e1, e2, e1)   

    return SanitiseList(points)

def SolveIntersections(e1, e2, sub):
    points = []

    try:
        if e1.has(TrigonometricFunction) or e2.has(TrigonometricFunction):
            raise Exception

        for xValue in solve(e1 - e2):
            yValue = sub.subs("x", xValue)
            points.append(Point(xValue, yValue))
    except:
        # Get equally spaced numbers
        lowerBound = -10
        upperBound = 10
        samples = 20
        step = (upperBound - lowerBound) / (samples - 1)
        initialValues = [lowerBound + step * i for i in range(samples)]

        for initialValue in initialValues:
            try:
                xValue = nsolve(e1 - e2, initialValue)
                
                if xValue < lowerBound or xValue > upperBound:
                    continue

                yValue = sub.subs("x", xValue)
                points.append(Point(xValue, yValue))
            except:
                continue
            
    return points

def ExpressionToDecimal(expression):
    return round(expression, 3)

def FormatExpressionSympy(expression):
    expression = str(expression)

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

def SanitiseList(l):
    l = list(set(l))
    l.sort()
    return l

if __name__ == "__main__":
    # Equations should be inputted in the form f(x,y) = 0.
    x, y = symbols('x y', real = True)

    equations = input("Equations: ").split("|")

    isolatedEquations = []

    for equation in [sympify(FormatExpressionSympy(equation), rational=True) for equation in equations]:
        equationBundle = solve(equation, "y")
        isolatedEquations += equationBundle
        EquationBundles.append(equationBundle)

    print("x-Intercepts:")
    for point in GetXIntercepts(isolatedEquations):
        print(f"\t{point}")

    print("y-Intercepts:")
    for point in GetYIntercepts(isolatedEquations):
        print(f"\t{point}")

    print("Critical Points:")
    for point in GetCriticalPoints(isolatedEquations):
        print(f"\t{point}")

    print("Intersections:")
    for point in GetIntersections(isolatedEquations):
        print(f"\t{point}")