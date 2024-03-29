{-# LANGUAGE
    StandaloneDeriving
  , KindSignatures
  , TypeFamilies
  , FlexibleContexts
  , UndecidableInstances
 #-}
module Generics.SingleRec.Base where

-- Generic representation.

data Id         r = Id   { unId :: r }                        deriving Show
data K    a     r = K    { unK :: a }                         deriving Show
data Unit       r = Unit                                      deriving Show
data Sum    f g r = Inl  { left :: f r} | Inr { right :: g r} deriving Show
data Prod   f g r = Prod { fist :: f r, second :: g r}        deriving Show
data Con    f   r = Con  { conName :: String, unCon :: f r}   deriving Show
data F      f   r = F    { unF :: f r}                        deriving Show

-- Fixed-point constructor.

newtype Fix f = In {out :: f (Fix f)}

deriving instance Show (f (Fix f)) => Show (Fix f)

-- Generic recursive view on data types.

class View a where
  name :: a -> String

class {-(View a, Functor (PF a)) => -} PFView a where
  type PF a :: * -> *
  from      :: a -> PF a a
  to        :: PF a a -> a
--   ctors     :: a -> [String]

instance View Int where
  name = const "Int"

instance View Bool where
  name = const "Bool"

