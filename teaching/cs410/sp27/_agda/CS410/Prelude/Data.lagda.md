---
title: "Data"
order: 0.2
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Data.lagda.md
---

```agda
module CS410.Prelude.Data where

open import Agda.Primitive using (Level; _⊔_)

private
  variable
    a b c d : Level
    A : Set a
    B : Set b
    C : Set c
    D : Set d

-- empty
data ⊥ : Set where

⊥-elim : ⊥ → A
⊥-elim ()

-- unit
record ⊤ : Set where
  constructor tt

-- dependent pairs
infixr 4 _,_
infixr 2 _×_

record Σ (A : Set a) (B : A → Set b) : Set (a ⊔ b) where
  constructor _,_
  field
    fst : A
    snd : B fst
open Σ public

{-# BUILTIN SIGMA Σ #-}

infix 2 Σ-syntax

Σ-syntax : (A : Set a) → (A → Set b) → Set (a ⊔ b)
Σ-syntax = Σ

syntax Σ-syntax A (λ x → B) = Σ[ x ∈ A ] B

-- pairs
_×_ : Set a → Set b → Set (a ⊔ b)
A × B = Σ A (λ _ → B)

⟨_,_⟩ : (A → B) → (A → C) → A → B × C
⟨ f , g ⟩ x = f x , g x

map-× : (A → C) → (B → D) → A × B → C × D
map-× f g (x , y) = f x , g y

curry : (A × B → C) → A → B → C
curry f x y = f (x , y)

uncurry : (A → B → C) → A × B → C
uncurry f (x , y) = f x y

-- sums
infixr 1 _⊎_

data _⊎_ (A : Set a) (B : Set b) : Set (a ⊔ b) where
  inl : A → A ⊎ B
  inr : B → A ⊎ B

either : (A → C) → (B → C) → A ⊎ B → C
either f g (inl x) = f x
either f g (inr y) = g y

-- natural numbers
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

{-# BUILTIN NATURAL ℕ #-}

-- booleans
data Bool : Set where
  false true : Bool
```

