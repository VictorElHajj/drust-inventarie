module Web.FrontController where

import Generated.Types
import IHP.ControllerSupport
import IHP.LoginSupport.Middleware
import IHP.RouterPrelude
import IHP.Welcome.Controller
import Web.Controller.Borrowers
import Web.Controller.Loans
import Web.Controller.Sessions
import Web.Controller.Tools
import Web.Types

instance FrontController WebApplication where
  controllers =
    [ startPage ToolsAction,
      parseRoute @SessionsController,
      -- Generator Marker
      parseRoute @LoansController,
      parseRoute @ToolsController,
      parseRoute @BorrowersController
    ]

instance InitControllerContext WebApplication where
  initContext =
    initAuthentication @User
