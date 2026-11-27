---
title: "Prelude"
order: 0
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude.lagda.md
---

```agda
module CS410.Prelude where

open import Agda.Primitive public using (Level; _⊔_; lzero; lsuc)
```

## Functions

```agda
open import CS410.Prelude.Function public
```

## Data

```agda
open import CS410.Prelude.Data public
```

## Logic

```agda
open import CS410.Prelude.Logic public
```

## Equality

```agda
open import CS410.Prelude.Equality public
```

## Axioms

```agda
open import CS410.Prelude.Foundations public
  using (coe; funext; funext-implicit; happly; propext; subst; subst-prop)
```

## Quotients

```agda
open import CS410.Prelude.Quotient public using (_/_; [_])

module Quotient = CS410.Prelude.Quotient hiding (elim-β)
```

