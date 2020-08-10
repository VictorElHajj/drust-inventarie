module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute ToolsController
type instance ModelControllerMap WebApplication Tool = ToolsController

instance AutoRoute LoansController
type instance ModelControllerMap WebApplication Loan = LoansController

