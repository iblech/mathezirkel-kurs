-- most famous dependent type: Vector n (the type of vectors of length n)   (..,..,..,..,..)
-- not a dependent type: Set<String>

{-
concat : (n : ℕ) → (m : ℕ) → Vector n → Vector m → Vector (n + m)
-- example usage: concat (succ zero) (succ zero) vec1 vec2

concat : {n : ℕ} {m : ℕ} → Vector n → Vector m → Vector (n + m)
concat : {n m : ℕ} → Vector n → Vector m → Vector (n + m)
-- example usage: concat vec1 vec2
-}

-- type = set

-- (zero ≡ succ zero) is a type, namely the type of all possible reasons that zero equals succ zero
-- in other words: this is the empty type.

-- (zero ≡ zero) is a type. It contains precisely one value: namely refl.

infix 5 _≡_

data _≡_ {X : Set} : X → X → Set where
  refl : {x : X} → (x ≡ x)
--  bailout : {x y : X} → (x ≡ y)

-- Set is the type of all types.   (Not actually all types. Most of them.)
-- (A type which is not contained in Set is: Set itself. :-))
-- ((Set is contained in something called Set₁))

trans : {X : Set} → {x y z : X} → (x ≡ y) → (y ≡ z) → (x ≡ z)
--trans {X} {x} {x} {z} (refl {X} {x}) refl = refl
trans {X} {x} {.x} {.x} refl refl = refl

{-
data _≣_ : ℕ → ℕ → Set where
  refl : {x : ℕ} → (x ≡ x)
-}

-- enter ℕ as follows: \bN
-- in Haskell: data ℕ = Zero | Succ ℕ
data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

{-
interestingLemma : (zero ≡ succ zero)
interestingLemma = bailout

reason1 : (zero ≡ zero)
reason1 = refl {ℕ} {zero}

reason2 : (zero ≡ zero)
reason2 = bailout
-}

veryBasicLemma : (zero ≡ zero)
veryBasicLemma = refl

-- the number zero, an even more important number
ex0 : ℕ
ex0 = zero

-- the number four, an important number
ex1 : ℕ
ex1 = succ (succ (succ (succ zero)))

infixl 6 _+_
infixl 7 _·_

_+_ : (n : ℕ) → (a : ℕ) → ℕ
n + zero = n
n + succ m = succ (n + m)

_·_ : ℕ → ℕ → ℕ
n · zero = zero
n · succ m = n · m + n
-- n * (m + 1) = n*m  +  n

ex2 : ℕ
ex2 = ex1 + ex1

symm : {X : Set} {x y : X} → (x ≡ y) → (y ≡ x)
symm = {!!}

cong : {X Y : Set} {x y : X} → (f : X → Y) → (x ≡ y) → (f x ≡ f y)
cong = {!!}

lemma : (n : ℕ) → ((zero + n) ≡ n)
lemma zero = refl {ℕ} {zero}  -- short for: refl {ℕ} {zero + zero}.
-- note that: zero + zero is the SAME as
-- zero, hence (zero + zero ≡ zero) is the SAME type as (zero ≡ zero)
lemma (succ k) = foo
  where
  bar : (zero + k) ≡ k
  bar = lemma k
  foo : succ (zero + k) ≡ succ k
  foo = (cong succ) bar
  -- "succ (zero + n)" denotes a certain specific dependent type.
  -- "zero + succ n" also denotes a certain specific dependent type.
  -- These two types are THE SAME.

lemma' : (n m : ℕ) → (succ n + m ≡ succ (n + m))
lemma' = {!!}

associativity : {n m p : ℕ} → (n + (m + p) ≡ (n + m) + p)
associativity = {!!}

commutativity : {n m : ℕ} → (n + m ≡ m + n)
commutativity = ?

-- for ≡: \==
-- for automatically doing it: Ctrl-c Ctrl-r
-- for normalization: Ctrl-c Ctrl-n
-- for checking:      Ctrl-c Ctrl-l
-- for checking that hole: Ctrl-c Ctrl-space
-- for splitting on the several cases: Ctrl-c Ctrl-c
