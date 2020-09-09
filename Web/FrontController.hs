module Web.FrontController where
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Web.Types

-- Controller Imports
import Web.Controller.Loans
import Web.Controller.Tools
import IHP.Welcome.Controller

instance FrontController WebApplication where
    controllers = 
        [ startPage ToolsAction 
        -- Generator Marker
        , parseRoute @LoansController
        , parseRoute @ToolsController
        ]

instance InitControllerContext WebApplication
