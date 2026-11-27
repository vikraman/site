---
title: "Strict equality"
order: 0.7
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Strict.lagda.md
---

```agda
module CS410.Prelude.Strict where

open import Agda.Primitive using (Level)

private
  variable
    a b : Level
    A : Set a
    B : Set b
    x y : A

-- strict equality in Set, also used for rewriting
infix 4 _≣_

data _≣_ {A : Set a} (x : A) : A → Set a where
  refl : x ≣ x

{-# BUILTIN EQUALITY _≣_ #-}
{-# BUILTIN REWRITE _≣_ #-}

sym : x ≣ y → y ≣ x
sym refl = refl

cong : (f : A → B) → x ≣ y → f x ≣ f y
cong f refl = refl
```

