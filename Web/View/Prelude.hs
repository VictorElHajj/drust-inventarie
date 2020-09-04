module Web.View.Prelude
( module IHP.ViewPrelude
, module Web.View.Layout
, module Generated.Types
, module Web.Types
, module Web.View.Context
, module Application.Helper.View
, SqlEnum(..)
) where

import IHP.ViewPrelude
import Web.View.Layout
import Generated.Types
import Web.Types
import Web.Routes ()
import Web.View.Context
import Application.Helper.View

class SqlEnum a where
    showSE :: a -> Text
    listSE :: [a]

instance SqlEnum Status where
    showSE Available = "Tillgänglig"
    showSE Loaned = "Utlånad"
    showSE Missing = "Borta"
    listSE = [Available, Loaned, Missing]