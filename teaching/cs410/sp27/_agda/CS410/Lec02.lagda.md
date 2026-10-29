---
title: "Lecture 2: TBD"
order: 2
draft: true
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Lec02.lagda.md
---

{{< include ../_macros.qmd >}}

```agda
module CS410.Lec02 where

open import CS410.Prelude
open import CS410.Lec01
```

::: {.callout-note collapse="true" title="Recall: Theorem (Right unit)"}

{{< external CS410.Lec01.md#thm-plus-zero >}}

:::

We proved [Theorem (Right unit)](CS410.Lec01.md#thm-plus-zero) as [`+-zero`](CS410.Lec01.md#+-zero).

::: {#thm-plus-suc}
**(Successor).** For all $m, n \in \Nat$, $m + (n + 1) = (m + n) + 1$.
:::

```agda
+-suc : ∀ m n → m + suc n ≡ suc (m + n)
+-suc zero    n = refl
+-suc (suc m) n = cong suc (+-suc m n)
```

