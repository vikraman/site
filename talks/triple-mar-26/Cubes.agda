{-# OPTIONS --cubical --safe --guardedness -WnoUnsupportedIndexedMatch #-}

module Cubes where

------------------------------------------------------------------------------
--
--         Programming with Cubes
--
--          Vikraman Choudhury    <vikraman.choudhury@strath.ac.uk>
--          Rin Liu               <rin.liu@strath.ac.uk>
--
--           Mathematically Structured Programming group
--               Computer and Information Sciences
--                   University of Strathclyde
--
------------------------------------------------------------------------------













------------------------------------------------------------------------------
-- We'll be using the Cubical Agda standard Library:

open import Cubical.Foundations.Prelude
  renaming ( congS to ap
           ; cong to apd
           ; congP to apP
           ; subst to tpt
           ) public
open import Cubical.Foundations.HLevels public
open import Cubical.Foundations.Path public
open import Cubical.Foundations.GroupoidLaws public
open import Cubical.Foundations.Function public
open import Cubical.Foundations.Equiv public
open import Cubical.Foundations.Isomorphism public
open import Cubical.Foundations.Function public
open import Cubical.Data.Sigma public
open import Cubical.Data.Nat
open import Cubical.Data.Maybe
open import Cubical.Data.Unit
open import Cubical.Data.Empty
open import Cubical.Foundations.Univalence

------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Points, Lines, Squares, Cubes...

------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Lists, Vectors
------------------------------------------------------------------------------

module Lists where

  data List {a} (A : Type a) : Type a where
    []  : List A
    _∷_ : A → List A → List A

  head : ∀ {a} {A : Type a} → List A → Maybe A
  head [] = nothing
  head (x ∷ xs) = just x

module Vectors where

  data Vec {a} (A : Type a) : ℕ → Type a where
    []  : Vec A zero
    _∷_ : {n : ℕ} → A → Vec A n → Vec A (suc n)

  head : ∀ {a} {A : Type a} {n : ℕ} → Vec A (suc n) → A
  head (x ∷ xs) = x

------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Spicy Lists, Spicy Vectors
------------------------------------------------------------------------------

module SLists where

  infixr 10 _∷_

  data SList {a} (A : Type a) : Type a where
    []  : SList A
    _∷_ : A → SList A → SList A
    swap : ∀ (x y : A) {xs : SList A} → x ∷ y ∷ xs ≡ y ∷ x ∷ xs

  module SListElim {a p} {A : Type a} (P : SList A → Type p)
         ([]* : P [])
         (_∷*_ : (x : A) {xs : SList A} → P xs → P (x ∷ xs))
         (swap* : (x y : A) {xs : SList A} → (u : P (x ∷ y ∷ xs)) → (v : P (y ∷ x ∷ xs)) → PathP (λ i → P (swap x y {xs} i)) u v) where

    f : (xs : SList A) → P xs
    f [] = []*
    f (x ∷ xs) = x ∷* f xs
    f (swap x y {xs} i) = swap* x y (x ∷* (y ∷* f xs)) (y ∷* (x ∷* f xs)) i

  as : SList ℕ
  as = 1 ∷ 2 ∷ 3 ∷ []

  bs : SList ℕ
  bs = 3 ∷ 2 ∷ 1 ∷ []

  p : as ≡ bs
  p = swap 1 2 ∙ ap (2 ∷_) (swap 1 3) ∙ swap 2 3

  q : as ≡ bs
  q = ap (1 ∷_) (swap 2 3) ∙ swap 1 3 ∙ ap (3 ∷_) (swap 1 2)

  -- _ : p ≡ q
  -- _ = {!!}

  -- head : ∀ {a} {A : Type a} → SList A → Maybe A
  -- head [] = nothing
  -- head (x ∷ xs) = just x
  -- head (swap x y i) = {!!}

module WildMonoid where

  open import Cubical.Data.List

  record WM {a} (A : Type a) : Type a where
    infixr 10 _⊕_
    field
      e : A
      _⊕_ : A → A → A
      unitl : ∀ x → e ⊕ x ≡ x
      unitr : ∀ x → x ⊕ e ≡ x
      assocr : ∀ x y z → (x ⊕ y) ⊕ z ≡ x ⊕ (y ⊕ z)

  record WMHom {a b} {A : Type a} {B : Type b} (M : WM A) (N : WM B) : Type (ℓ-max a b) where
    private
      module M = WM M
      module N = WM N
    field
      ϕ : A → B
      preserves-e : ϕ M.e ≡ N.e
      preserves-⊕ : ∀ x y → ϕ (x M.⊕ y) ≡ ϕ x N.⊕ ϕ y

  ListWM : ∀ {a} {A : Type a} → WM (List A)
  ListWM .WM.e = []
  ListWM .WM._⊕_ = _++_
  ListWM .WM.unitl xs = refl
  ListWM .WM.unitr = ++-unit-r
  ListWM .WM.assocr = ++-assoc

  η : ∀ {a} {A : Type a} → A → List A
  η a = [ a ]

  module _ {a m} {A : Type a} {M : Type m} (M* : WM M) (f : A → M) where
    private module M = WM M*
    [_]_♯ : List A → M
    [_]_♯ [] = M.e
    [_]_♯ (x ∷ xs) = f x M.⊕ [_]_♯ xs

    module _ (h* : WMHom ListWM M*) where
      private module h = WMHom h*
      [_]_♯-uniq : h.ϕ ∘ η ≡ f → ∀ xs → h.ϕ xs ≡ [_]_♯ xs
      [_]_♯-uniq p [] = h.preserves-e
      [_]_♯-uniq p (x ∷ xs) = h.preserves-⊕ [ x ] xs ∙ ap (M._⊕ h.ϕ xs) (funExt⁻ p x) ∙ ap (f x M.⊕_) ([_]_♯-uniq p xs)



  -- data SVec {a} (A : Type a) : ℕ → Type a where
  --   []  : SVec A zero
  --   _∷_ : {n : ℕ} → A → SVec A n → SVec A (suc n)
  --   swap : ∀ {n : ℕ} {x y : A} {xs : SVec A n} → x ∷ y ∷ xs ≡ y ∷ x ∷ xs
