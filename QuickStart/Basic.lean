-- Define a constant string
def hello := "world"

-- Define a function that adds 1 to a given natural number
def add1 (n : Nat) : Nat := n + 1

-- Evaluate the function add1 with argument 7
#eval add1 7

-- Evaluate a mathematical expression
#eval 1 + 2 * 5

-- Evaluate a string concatenation with a conditional expression
#eval String.append "it is " (if 1 > 2 then "yes" else "no")

-- TYPES

-- Nat does not support negative numbers
#eval (1 - 2 : Nat)

-- Int supports negative numbers
#eval (1 - 2 : Int)


-- FUNCTIONS

def helloWithParams (name : String) : String := "Hello, " ++ name

#eval helloWithParams "Lean"

-- Structures

structure Point where
  x : Float
  y : Float
deriving Repr

def p : Point := { x := 1.0, y := 2.0 }

#eval p

#eval p.x
#eval p.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))

#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }


structure Point3D where
  x : Float
  y : Float
  z : Float
deriving Repr

def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }

-- showing inmutability
def zeroX (p : Point) : Point :=
  { p with x := 0 }

-- Mutable version
def zeroX2 (p : Point) : Point :=
  { x := 0, y := p.y }
