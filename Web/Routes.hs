module Web.Routes where

import Generated.Types
import IHP.RouterPrelude
import Web.Types

-- Generator Marker
instance AutoRoute ToolsController

type instance ModelControllerMap WebApplication Tool = ToolsController

instance AutoRoute LoansController

type instance ModelControllerMap WebApplication Loan = LoansController

instance AutoRoute SessionsController

instance AutoRoute BorrowersController
type instance ModelControllerMap WebApplication Borrower = BorrowersController

