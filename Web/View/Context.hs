module Web.View.Context where

import Application.Helper.Controller
import Generated.Types
import qualified IHP.Controller.Session
import IHP.ControllerSupport (RequestContext (RequestContext))
import qualified IHP.ControllerSupport
import IHP.ModelSupport
import IHP.Prelude
import qualified IHP.ViewSupport as ViewSupport
import Web.Types
import Web.View.Layout

instance ViewSupport.CreateViewContext ViewContext where
  type ViewApp ViewContext = WebApplication
  createViewContext = do
    flashMessages <- IHP.Controller.Session.getAndClearFlashMessages
    let viewContext =
          ViewContext
            { requestContext = ?requestContext,
              user = currentUserOrNothing,
              flashMessages,
              controllerContext = ?controllerContext,
              layout = let ?viewContext = viewContext in defaultLayout
            }
    pure viewContext
