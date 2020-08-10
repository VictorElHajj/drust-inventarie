module Web.Types where
import IHP.Prelude
import qualified IHP.Controller.Session
import qualified IHP.ControllerSupport as ControllerSupport
import IHP.ModelSupport
import Application.Helper.Controller
import IHP.ViewSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)

data ViewContext = ViewContext
    { requestContext :: ControllerSupport.RequestContext
    , flashMessages :: [IHP.Controller.Session.FlashMessage]
    , controllerContext :: ControllerSupport.ControllerContext
    , layout :: Layout
    }

data ToolsController
    = ToolsAction
    | NewToolAction
    | ShowToolAction { toolId :: !(Id Tool) }
    | CreateToolAction
    | EditToolAction { toolId :: !(Id Tool) }
    | UpdateToolAction { toolId :: !(Id Tool) }
    | DeleteToolAction { toolId :: !(Id Tool) }
    deriving (Eq, Show, Data)

data LoansController
    = LoansAction
    | NewLoanAction {toolId :: !(Id Tool)}
    | ShowLoanAction { loanId :: !(Id Loan) }
    | CreateLoanAction
    | EditLoanAction { loanId :: !(Id Loan) }
    | UpdateLoanAction { loanId :: !(Id Loan) }
    | DeleteLoanAction { loanId :: !(Id Loan) }
    deriving (Eq, Show, Data)
