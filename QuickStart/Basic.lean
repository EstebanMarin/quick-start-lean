-- https://lean-lang.org/functional_programming_in_lean


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


-- Data types and patterns
-- Lets talk about inductive data types
/-
inductive Bool where
  | false : Bool
  | true : Bool
-/

/- another exameple

inductive Nat where
  | zero : Nat
  | succ (n : Nat) : Nat

-/

/-
Datatypes that allow choices are called sum types and datatypes that can include instances of
themselves are called recursive datatypes. Recursive sum types are called inductive datatypes
-/

-- Pattern Matching

def isZero (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ _ => false

#eval isZero 0
#eval isZero 1

-- Patern matching with structures
def depth (p : Point3D) : Float :=
  match p with
  | { x:= _, y := _, z := d } => d

#eval depth { x := 1.0, y := 2.0, z := 3.0 }

/-
This pattern of thought is typical for writing recursive functions
on Nat. First, identify what to do for zero.
Then, determine how to transform a result for an arbitrary Nat
into a result for its successor, and apply this transformation to the
result of the recursive call.
This pattern is called structural recursion.
-/

/-
Unlike many languages, Lean ensures by default that every recursive function will
eventually reach a base case. From a programming perspective, this rules out accidental infinite loops.
But this feature is especially important when proving theorems, where infinite loops cause major difficulties.
A consequence of this is that Lean will not accept a version of even that attempts to invoke itself recursively
on the original number:

def evenLoops (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (evenLoops n)

fail to show termination for
  evenLoops
with errors
structural recursion cannot be used

well-founded recursion cannot be used, 'evenLoops' does not take any (non-fixed) arguments

-/

/-
Not every function can be easily written using structural recursion.
The understanding of addition as iterated Nat.succ, multiplication as iterated addition,
and subtraction as iterated predecessor suggests an implementation of division as iterated subtraction.
In this case, if the numerator is less than the divisor, the result is zero.
Otherwise, the result is the successor of dividing the numerator minus the divisor by the divisor.
-/

def plus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.succ (plus n k')

def times (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => Nat.zero
  | Nat.succ k' => plus n (times n k')

def minus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.pred (minus n k')

#eval Nat.succ 0
