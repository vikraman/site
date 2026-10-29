---
title: "Prelude"
order: 0
draft: true
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Prelude.lagda.md
---

```agda
module CS410.Prelude where
```

## Equality

```agda
open import Agda.Builtin.Equality public

cong : {A B : Set} (f : A → B) {x y : A} → x ≡ y → f x ≡ f y
cong f refl = refl
```

