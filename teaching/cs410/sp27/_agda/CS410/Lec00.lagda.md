---
title: "Lecture 0: Teaser"
order: 0
repo-actions: false
other-links:
  - text: Agda source
    icon: file-code
    href: ../_agda/CS410/Lec00.lagda.md
---

```agda
{-# OPTIONS --allow-unsolved-metas #-}

module CS410.Lec00 where

open import CS410.Prelude

private
  variable
    l m n : ℕ
```

## Agda for Haskellers

You're used to writing Haskell programs like this.

```haskell
data Nat = Zero | Suc Nat

add :: Nat -> Nat -> Nat
add Zero    n = n
add (Suc m) n = Suc (add m n)

even :: Nat -> Bool
even Zero    = True
even (Suc n) = not (even n)
```

Agda looks similar!

```agda
infixl 6 _+_

_+_ : ℕ → ℕ → ℕ
m + n = {!!}

2*_ : ℕ → ℕ
2* k = {!!}

not : Bool → Bool
not b = {!!}

even : ℕ → Bool
even n = {!!}
```

## Proofs are programs

But now we can write equations between programs, and prove things about them.

An equation that holds by computation, or definitionally, is proved by `refl`: Agda evaluates both sides to the same
value.

```agda
two-plus-two : 2 + 2 ≡ 4
two-plus-two = {!!}

even-ten : even 10 ≡ true
even-ten = {!!}
```

We will learn how to write proofs, both informally, on "paper" for humans, and formally, in Agda that is checked by the machine.

::: {#lem-not-not}
For every boolean $b$, $\mathsf{not}\,(\mathsf{not}\,b) = b$.
:::

::: {.proof}
`{!!}`
:::

```agda
not-not : (b : Bool) → not (not b) ≡ b
not-not b = {!!}
```

::: {#lem-even-double}
For every $k$, $\mathsf{even}\,(2k) = \mathsf{true}$ and
$\mathsf{even}\,(1 + 2k) = \mathsf{false}$.
:::

::: {.proof}
By induction on $k$. For $k = 0$, $\mathsf{even}\,0$ computes to
$\mathsf{true}$. For $k + 1$, $\mathsf{even}\,(2(k + 1))$ computes to
$\mathsf{not}\,(\mathsf{not}\,(\mathsf{even}\,(2k)))$, which is
$\mathsf{even}\,(2k)$ by @lem-not-not, and this is $\mathsf{true}$ by the
induction hypothesis. Then $\mathsf{even}\,(1 + 2k)$ computes to
$\mathsf{not}\,(\mathsf{even}\,(2k))$, which is $\mathsf{not}\,\mathsf{true}$,
which is $\mathsf{false}$.
:::

```agda
even-2* : (k : ℕ) → even (2* k) ≡ true
even-2* zero    = refl
even-2* (suc k) = trans (not-not (even (2* k))) (even-2* k)

even-1+2* : (k : ℕ) → even (1 + 2* k) ≡ false
even-1+2* k = cong not (even-2* k)
```

## Even and odd

::: {#def-even-odd}
A natural number $n$ is *even* if $n = 2k$ for some $k$, and *odd* if
$n = 1 + 2k$ for some $k$.
:::

In Agda, these are propositions.

```agda
Even : ℕ → Prop
Even n = ∃[ k ] n ≡ 2* k

Odd : ℕ → Prop
Odd n = ∃[ k ] n ≡ 1 + 2* k
```

Let's prove some propositions using these.

::: {#prp-even-4}
$4$ is even.
:::

::: {.proof}
`{!!}`
:::

```agda
even-4 : Even 4
even-4 = {!!}
```

::: {#prp-not-even-1}
$1$ is not even.
:::

::: {.proof}
`{!!}`
:::

```agda
¬even-1 : ¬ Even 1
¬even-1 p = {!!}
```

::: {#thm-even-or-odd}
Every number is even or odd.
:::

::: {.proof}
`{!!}`
:::

```agda
even-or-odd : (n : ℕ) → Even n ∨ Odd n
even-or-odd n = {!!}
```

## Booleans and propositions

::: {#lem-even-sound}
If $n$ is even then $\mathsf{even}\,n = \mathsf{true}$, and if $n$ is odd then
$\mathsf{even}\,n = \mathsf{false}$.
:::

::: {.proof}
If $n = 2k$ then $\mathsf{even}\,n = \mathsf{even}\,(2k) = \mathsf{true}$, and
if $n = 1 + 2k$ then $\mathsf{even}\,n = \mathsf{false}$, both by
@lem-even-double.
:::

```agda
Even→even : Even n → even n ≡ true
Even→even (k , refl) = even-2* k

Odd→even : Odd n → even n ≡ false
Odd→even (k , refl) = even-1+2* k
```

::: {#lem-even-complete}
If $\mathsf{even}\,n = \mathsf{true}$ then $n$ is even.
:::

::: {.proof}
By @thm-even-or-odd, $n$ is even or odd. If it is even we are done. If it is
odd, then $\mathsf{even}\,n = \mathsf{false}$ by @lem-even-sound, which
contradicts $\mathsf{even}\,n = \mathsf{true}$.
:::

```agda
even→Even : (n : ℕ) → even n ≡ true → Even n
even→Even n e with even-or-odd n
... | inl p = p
... | inr q with trans (sym e) (Odd→even q)
... | ()
```

::: {#lem-not-both}
No number is both even and odd.
:::

::: {.proof}
By @lem-even-sound, $\mathsf{even}\,n$ would be both $\mathsf{true}$ and
$\mathsf{false}$, which are different constructors.
:::

```agda
not-both : Even n → Odd n → False
not-both p q with trans (sym (Even→even p)) (Odd→even q)
... | ()
```

## Equal propositions

::: {#thm-even-equal}
The predicate $\mathsf{Even}$ is equal to $n \mapsto (\mathsf{even}\,n = \mathsf{true})$.
:::

::: {.proof}
`{!!}`
:::

```agda
Even≡even : Even ≡ (λ n → even n ≡ true)
Even≡even = {!!}
```

::: {#prp-even-100}
$100$ is even.
:::

::: {.proof}
`{!!}`
:::

```agda
even-100 : Even 100
even-100 = {!!}
```

## Parity as a quotient

::: {#def-same-parity}
Two numbers $m$ and $n$ have the *same parity*, written $m \sim n$, if $m$ is
even exactly when $n$ is even.
:::

Identifying numbers with the same parity gives the quotient set
$\mathsf{Bits}$.

```agda
infix 4 _~_

_~_ : ℕ → ℕ → Prop
m ~ n = (Even m → Even n) ∧ (Even n → Even m)

Bits : Set
Bits = ℕ / _~_
```

::: {#lem-sim-equiv}
$\sim$ is an equivalence relation.
:::

::: {.proof}
It is "if and only if" applied to evenness, so it is reflexive, symmetric and
transitive because implication is.
:::

```agda
~-refl : n ~ n
~-refl = (λ p → p) , (λ p → p)

~-sym : m ~ n → n ~ m
~-sym (f , g) = g , f

~-trans : l ~ m → m ~ n → l ~ n
~-trans (f , g) (h , k) = (λ p → h (f p)) , (λ p → g (k p))
```

::: {#lem-even-suc}
$n + 1$ is even exactly when $n$ is not even.
:::

::: {.proof}
If $n + 1 = 2k$ then $k \neq 0$, so $k = k' + 1$ and $n = 1 + 2k'$ is odd, hence
not even by @lem-not-both. Conversely, if $n$ is not even then it is odd by
@thm-even-or-odd, say $n = 1 + 2k$, and then $n + 1 = 2(k + 1)$.
:::

```agda
suc-even : Even (suc n) → Odd n
suc-even (zero  , ())
suc-even (suc k , refl) = k , refl

odd-suc : Odd n → Even (suc n)
odd-suc (k , p) = suc k , cong suc p

even-suc : Even (suc n) → ¬ Even n
even-suc e p = not-both p (suc-even e)

not-even-suc : (n : ℕ) → ¬ Even n → Even (suc n)
not-even-suc n f with even-or-odd n
... | inl p with f p
... | ()
not-even-suc n f | inr q = odd-suc q
```

::: {#lem-suc-respects}
If $m \sim n$ then $m + 1 \sim n + 1$.
:::

::: {.proof}
`{!!}`
:::

```agda
suc-respects : m ~ n → suc m ~ suc n
suc-respects p = {!!}
```

So $\mathsf{Bits}$ is a copy of the booleans, with negation given by the
successor function.

```agda
true₂ false₂ : Bits
true₂  = [ 0 ]
false₂ = [ 1 ]

not₂ : Bits → Bits
not₂ = {!!}
```

The quotient map is the function $\mathsf{even}$ from the start of the lecture.

```agda
even₂ : ℕ → Bits
even₂ n = [ n ]
```

::: {#thm-even-quotient}
$\mathsf{even}_2\,0 = \mathsf{true}_2$ and
$\mathsf{even}_2\,(n + 1) = \mathsf{not}_2\,(\mathsf{even}_2\,n)$, as in the
Haskell definition of $\mathsf{even}$.
:::

::: {.proof}
`{!!}`
:::

```agda
even₂-zero : even₂ zero ≡ true₂
even₂-zero = {!!}

even₂-suc : (n : ℕ) → even₂ (suc n) ≡ not₂ (even₂ n)
even₂-suc n = {!!}
```

::: {#prp-true-false}
$\mathsf{true}_2 \neq \mathsf{false}_2$.
:::

::: {.proof}
`{!!}`
:::

```agda
true₂≢false₂ : true₂ ≢ false₂
true₂≢false₂ e = {!!}
```

## From parity to booleans

::: {#lem-bool-iff}
Two booleans that are $\mathsf{true}$ together are equal.
:::

::: {.proof}
By cases: if they differ, one of them is $\mathsf{true}$ and the other is
$\mathsf{false}$, which are different constructors.
:::

```agda
bool-iff : (a b : Bool) → (a ≡ true → b ≡ true) → (b ≡ true → a ≡ true) → a ≡ b
bool-iff false false f g = refl
bool-iff true  true  f g = refl
bool-iff false true  f g with g refl
... | ()
bool-iff true  false f g with f refl
... | ()
```

::: {#lem-even-respects}
The function $\mathsf{even}$ respects $\sim$.
:::

::: {.proof}
If $m \sim n$ then $\mathsf{even}\,m = \mathsf{true}$ exactly when $m$ is even
(@lem-even-sound, @lem-even-complete), exactly when $n$ is even, exactly when
$\mathsf{even}\,n = \mathsf{true}$. So $\mathsf{even}\,m = \mathsf{even}\,n$ by
@lem-bool-iff.
:::

```agda
even-respects : m ~ n → even m ≡ even n
even-respects {m} {n} (f , g) =
  bool-iff (even m) (even n)
    (λ e → Even→even (f (even→Even m e)))
    (λ e → Even→even (g (even→Even n e)))
```

So $\mathsf{even}$ gives a function out of the quotient.

```agda
parity : Bits → Bool
parity = {!!}
```

::: {#thm-parity-even}
The composite $\mathbb{N} \to \mathsf{Bits} \to \mathsf{Bool}$ of
$\mathsf{even}_2$ and $\mathsf{parity}$ is $\mathsf{even}$.
:::

::: {.proof}
`{!!}`
:::

```agda
parity-even₂ : (λ n → parity (even₂ n)) ≡ even
parity-even₂ = {!!}
```

