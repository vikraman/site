---
title: "Foundations"
order: 0.5
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Foundations.lagda.md
---

```agda
{-# OPTIONS --local-confluence-check #-}

module CS410.Prelude.Foundations where

open import Agda.Primitive using (Level)
open import CS410.Prelude.Equality
open import CS410.Prelude.Strict as Strict using (_≣_)

private
  variable
    a b : Level
    A : Set a
    B : Set b
    x y : A

postulate
  -- transport along an equation of types
  coe : A ≡ B → A → B

  -- transport along a reflexive equation is the identity
  coe-refl : (p : A ≡ A) (x : A) → coe p x ≣ x

{-# REWRITE coe-refl #-}

postulate
  funext : {B : A → Set b} {f g : (x : A) → B x} → (∀ x → f x ≡ g x) → f ≡ g

  propext : {P Q : Prop a} → (P → Q) → (Q → P) → P ≡ Q

module _ {B : A → Set b} where

  funext-implicit : {f g : ∀ {x} → B x} → (∀ x → f {x} ≡ g {x}) → (λ {x} → f {x}) ≡ (λ {x} → g {x})
  funext-implicit h = cong (λ k {x} → k x) (funext h)

  happly : {f g : (x : A) → B x} → f ≡ g → ∀ x → f x ≡ g x
  happly e x = cong (λ k → k x) e

-- transport in families of sets
subst : (P : A → Set b) {x y : A} → x ≡ y → P x → P y
subst P e = coe (cong P e)

-- transport in families of propositions
subst-prop : (P : A → Prop b) {x y : A} → x ≡ y → P x → P y
subst-prop P refl p = p

-- between the two equalities
from-strict : x ≣ y → x ≡ y
from-strict Strict.refl = refl

to-strict : x ≡ y → x ≣ y
to-strict {x = x} e = coe (cong (x ≣_) e) Strict.refl
```

