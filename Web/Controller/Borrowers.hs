module Web.Controller.Borrowers where

import Web.Controller.Prelude
import Web.View.Borrowers.Edit
import Web.View.Borrowers.Index
import Web.View.Borrowers.New
import Web.View.Borrowers.Show

instance Controller BorrowersController where
  beforeAction = ensureIsUser

  action BorrowersAction = do
    borrowers <- query @Borrower |> fetch
    render IndexView {..}
  action NewBorrowerAction = do
    let borrower = newRecord
    render NewView {..}
  action EditBorrowerAction {borrowerId} = do
    borrower <- fetch borrowerId
    render EditView {..}
  action UpdateBorrowerAction {borrowerId} = do
    borrower <- fetch borrowerId
    borrower
      |> buildBorrower
      |> ifValid \case
        Left borrower -> render EditView {..}
        Right borrower -> do
          borrower <- borrower |> updateRecord
          setSuccessMessage "Borrower updated"
          redirectTo EditBorrowerAction {..}
  action CreateBorrowerAction = do
    let borrower = newRecord @Borrower
    borrower
      |> buildBorrower
      |> ifValid \case
        Left borrower -> render NewView {..}
        Right borrower -> do
          borrower <- borrower |> createRecord
          setSuccessMessage "Borrower created"
          redirectTo BorrowersAction
  action DeleteBorrowerAction {borrowerId} = do
    borrower <- fetch borrowerId
    deleteRecord borrower
    setSuccessMessage "Borrower deleted"
    redirectTo BorrowersAction

buildBorrower borrower =
  borrower
    |> fill @["name", "email", "phone", "lastActive"]
