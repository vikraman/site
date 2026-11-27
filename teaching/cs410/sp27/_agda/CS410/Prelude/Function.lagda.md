---
title: "Functions"
order: 0.1
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude/Function.lagda.md
---

```agda
module CS410.Prelude.Function where

open import Agda.Primitive using (Level)

private
  variable
    a b c : Level
    A : Set a
    B : Set b
    C : Set c

infixr 9 _∘_
infixr 0 _$_

id : A → A
id x = x

const : A → B → A
const x _ = x

flip : (A → B → C) → B → A → C
flip f y x = f x y

_∘_ : (B → C) → (A → B) → A → C
(g ∘ f) x = g (f x)

_$_ : (A → B) → A → B
f $ x = f x
```

