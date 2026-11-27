---
title: "Logic"
order: 0.3
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Logic.lagda.md
---

```agda
module CS410.Prelude.Logic where

open import Agda.Primitive using (Level; _⊔_)
open import CS410.Prelude.Data

private
  variable
    a b : Level
    A : Set a

-- truth and falsity
record True : Prop where
  constructor tt

data False : Prop where

absurd : False → A
absurd ()

infix 3 ¬_

¬_ : Prop a → Prop a
¬ P = P → False

-- conjunction
infixr 4 _,_
infixr 2 _∧_

record _∧_ (P : Prop a) (Q : Prop b) : Prop (a ⊔ b) where
  constructor _,_
  field
    fst : P
    snd : Q
open _∧_ public

-- disjunction
infixr 1 _∨_

data _∨_ (P : Prop a) (Q : Prop b) : Prop (a ⊔ b) where
  inl : P → P ∨ Q
  inr : Q → P ∨ Q

-- existential
data ∃ {A : Set a} (P : A → Prop b) : Prop (a ⊔ b) where
  _,_ : (x : A) → P x → ∃ P

infix 2 ∃-syntax

∃-syntax : {A : Set a} → (A → Prop b) → Prop (a ⊔ b)
∃-syntax = ∃

syntax ∃-syntax (λ x → P) = ∃[ x ] P

-- a set as a proposition: it has an element
data Squash (A : Set a) : Prop a where
  squash : A → Squash A

-- a proposition as a set
record Box (P : Prop a) : Set a where
  constructor box
  field unbox : P
open Box public

-- elements satisfying a proposition
record Subset (A : Set a) (P : A → Prop b) : Set (a ⊔ b) where
  constructor _,_
  field
    elem : A
    prop : P elem
open Subset public

-- decidable propositions
data Dec (P : Prop a) : Set a where
  yes : P → Dec P
  no  : ¬ P → Dec P

⌊_⌋ : {P : Prop a} → Dec P → Bool
⌊ yes _ ⌋ = true
⌊ no _ ⌋  = false
```

