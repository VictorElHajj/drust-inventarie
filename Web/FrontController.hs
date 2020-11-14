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
import Web.Controller.Users
import Web.Types
import Web.View.Layout (defaultLayout)
import Web.View.Prelude (setLayout)

instance FrontController WebApplication where
  controllers =
    [ startPage ToolsAction,
      parseRoute @SessionsController,
      -- Generator Marker
      parseRoute @UsersController,
      parseRoute @LoansController,
      parseRoute @ToolsController,
      parseRoute @BorrowersController
    ]

instance InitControllerContext WebApplication where
  initContext = do
    initAuthentication @User
    setLayout defaultLayout
