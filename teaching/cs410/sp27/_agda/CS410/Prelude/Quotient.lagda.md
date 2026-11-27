---
title: "Quotients"
order: 0.6
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Quotient.lagda.md
---

```agda
{-# OPTIONS --local-confluence-check #-}

module CS410.Prelude.Quotient where

open import Agda.Primitive using (Level; _⊔_)
open import CS410.Prelude.Equality
open import CS410.Prelude.Foundations
open import CS410.Prelude.Strict using (_≣_)

private
  variable
    a b c r s : Level

-- quotients by propositional relations
infixl 35 _/_

postulate
  _/_ : (A : Set a) (R : A → A → Prop r) → Set (a ⊔ r)

module _ {A : Set a} {R : A → A → Prop r} where

  postulate
    [_] : A → A / R
    sound : {x y : A} → R x y → [ x ] ≡ [ y ]

    elim : (P : A / R → Set b) (f : (x : A) → P [ x ])
           → (∀ {x y} (ρ : R x y) → subst P (sound ρ) (f x) ≡ f y)
           → (q : A / R) → P q

    elim-β : (P : A / R → Set b) (f : (x : A) → P [ x ])
               (fρ : ∀ {x y} (ρ : R x y) → subst P (sound ρ) (f x) ≡ f y) (x : A)
             → elim P f fρ [ x ] ≣ f x

    ind : (P : A / R → Prop b) → ((x : A) → P [ x ]) → (q : A / R) → P q

  {-# REWRITE elim-β #-}

module _ {A : Set a} {R : A → A → Prop r} where

  lift : {B : Set b} (f : A → B) → (∀ {x y} → R x y → f x ≡ f y) → A / R → B
  lift {B = B} f fρ = elim (λ _ → B) f fρ

  map : {B : Set b} {R′ : B → B → Prop s} (f : A → B) → (∀ {x y} → R x y → R′ (f x) (f y)) → A / R → B / R′
  map f fρ = lift (λ x → [ f x ]) (λ ρ → sound (fρ ρ))

module _ {A : Set a} {R : A → A → Prop r} {B : Set b} {R′ : B → B → Prop s} where

  lift₂ : {C : Set c} (f : A → B → C)
         → (∀ y {x x′} → R x x′ → f x y ≡ f x′ y) → (∀ x {y y′} → R′ y y′ → f x y ≡ f x y′)
         → A / R → B / R′ → C
  lift₂ f fρ fσ = lift (λ x → lift (f x) (fσ x)) (λ ρ → funext (ind _ (λ y → fρ y ρ)))

  ind₂ : (P : A / R → B / R′ → Prop c) → ((x : A) (y : B) → P [ x ] [ y ]) → (q : A / R) (q′ : B / R′) → P q q′
  ind₂ P f = ind (λ q → ∀ q′ → P q q′) (λ x → ind (P [ x ]) (f x))

-- quotients by equivalence relations are effective
module _ {A : Set a} {R : A → A → Prop r}
         (R-refl : ∀ {x} → R x x) (R-sym : ∀ {x y} → R x y → R y x) (R-trans : ∀ {x y z} → R x y → R y z → R x z) where

  effective : {x y : A} → [_] {R = R} x ≡ [ y ] → R x y
  effective {x} {y} e = subst-prop (λ P → P) (cong rel e) R-refl
    where
    rel : A / R → Prop r
    rel = lift (R x) (λ ρ → propext (λ p → R-trans p ρ) (λ p → R-trans p (R-sym ρ)))
```

