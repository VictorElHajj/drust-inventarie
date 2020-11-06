module Web.Types where

import Application.Helper.Controller
import Generated.Types
import qualified IHP.Controller.Session
import qualified IHP.ControllerSupport as ControllerSupport
import IHP.LoginSupport.Types
import IHP.ModelSupport
import IHP.Prelude
import IHP.ViewSupport

data WebApplication = WebApplication deriving (Eq, Show)

data ViewContext = ViewContext
  { requestContext :: ControllerSupport.RequestContext,
    flashMessages :: [IHP.Controller.Session.FlashMessage],
    controllerContext :: ControllerSupport.ControllerContext,
    layout :: Layout,
    user :: Maybe User
  }

data ToolsController
  = ToolsAction
  | NewToolAction
  | CreateToolAction
  | EditToolAction {toolId :: !(Id Tool)}
  | UpdateToolAction {toolId :: !(Id Tool)}
  | DeleteToolAction {toolId :: !(Id Tool)}
  deriving (Eq, Show, Data)

data LoansController
  = LoansAction
  | NewLoanAction {toolId :: !(Id Tool)}
  | CreateLoanAction
  | EditLoanAction {loanId :: !(Id Loan)}
  | UpdateLoanAction {loanId :: !(Id Loan)}
  | DeleteLoanAction {loanId :: !(Id Loan)}
  deriving (Eq, Show, Data)

data SessionsController
  = NewSessionAction
  | CreateSessionAction
  | DeleteSessionAction
  deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
  newSessionUrl _ = "/NewSession"
