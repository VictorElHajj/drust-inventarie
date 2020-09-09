module Web.View.Prelude
( module IHP.ViewPrelude
, module Web.View.Layout
, module Generated.Types
, module Web.Types
, module Web.View.Context
, module Application.Helper.View
, SqlEnum(..)
, trimSpaces
) where

import IHP.ViewPrelude
import Web.View.Layout
import Generated.Types
import Web.Types
import Web.Routes ()
import Web.View.Context
import Application.Helper.View
import qualified Data.Text as T (filter)

class SqlEnum a where
    showSE :: a -> Text
    listSE :: [a]

instance SqlEnum Status where
    showSE Available = "Tillgänglig"
    showSE Loaned = "Utlånad"
    showSE Missing = "Borta"
    listSE = [Available, Loaned, Missing]

trimSpaces :: Text -> Text
trimSpaces = T.filter (/= ' ')