---
title: "Exercise 1: solutions"
order: 102
draft: true
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Sol01.lagda.md
---

```agda
module CS410.Sol01 where

open import CS410.Prelude
open import CS410.Lec01
```

```agda
+-assoc : ∀ l m n → (l + m) + n ≡ l + (m + n)
+-assoc zero    m n = refl
+-assoc (suc l) m n = cong suc (+-assoc l m n)
```

