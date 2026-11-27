---
title: "Equality"
order: 0.4
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Equality.lagda.md
---

```agda
module CS410.Prelude.Equality where

open import Agda.Primitive using (Level)
open import CS410.Prelude.Logic using (False)

private
  variable
    a b c d : Level
    A : Set a
    B : Set b
    C : Set c
    D : Set d
    x y z : A

-- observational equality
infix 4 _≡_ _≢_

data _≡_ {A : Set a} (x : A) : A → Prop a where
  refl : x ≡ x

_≢_ : A → A → Prop _
x ≢ y = x ≡ y → False

sym : x ≡ y → y ≡ x
sym refl = refl

trans : x ≡ y → y ≡ z → x ≡ z
trans refl q = q

cong : (f : A → B) {x y : A} → x ≡ y → f x ≡ f y
cong f refl = refl

cong₂ : (f : A → B → C) {x y : A} {u v : B} → x ≡ y → u ≡ v → f x u ≡ f y v
cong₂ f refl refl = refl

cong₃ : (f : A → B → C → D) {x y : A} {u v : B} {s t : C} → x ≡ y → u ≡ v → s ≡ t → f x u s ≡ f y v t
cong₃ f refl refl refl = refl

module ≡-Reasoning where

  infix  1 begin_
  infixr 2 _≡⟨_⟩_ _≡⟨⟩_
  infix  3 _∎

  begin_ : x ≡ y → x ≡ y
  begin p = p

  _≡⟨_⟩_ : (x : A) → x ≡ y → y ≡ z → x ≡ z
  x ≡⟨ p ⟩ q = trans p q

  _≡⟨⟩_ : (x : A) → x ≡ y → x ≡ y
  x ≡⟨⟩ q = q

  _∎ : (x : A) → x ≡ x
  x ∎ = refl
```

