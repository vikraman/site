---
title: "Lecture 1: TBD"
order: 1
draft: true
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Lec01.lagda.md
---

{{< include ../_macros.qmd >}}

```agda
module CS410.Lec01 where

open import CS410.Prelude
```

## Definition

```agda
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

_+_ : ℕ → ℕ → ℕ
zero  + n = n
suc m + n = suc (m + n)
```

## Properties

::: {#thm-plus-zero}
**(Right unit).** For all $n \in \Nat$, $n + 0 = n$.
:::

::: {.proof}
By induction on $n$.
:::

```agda
+-zero : ∀ n → n + zero ≡ n
+-zero zero    = refl
+-zero (suc n) = cong suc (+-zero n)
```

