module Web.Controller.Borrowers where

import Data.Functor ((<&>))
import Web.Controller.Prelude
import Web.View.Borrowers.Edit
import Web.View.Borrowers.Index
import Web.View.Borrowers.New

instance Controller BorrowersController where
  beforeAction = ensureIsUser

  action BorrowersAction = do
    borrowers <- query @Borrower |> fetch
    render IndexView {..}
  action NewBorrowerAction =
    do
      currentTime <-
        getCurrentTime
          <&> utctDay
      let borrower =
            newRecord
              |> set #lastActive currentTime
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
          setSuccessMessage "Lånare redigerad"
          redirectTo BorrowersAction
  action CreateBorrowerAction = do
    let borrower = newRecord @Borrower
    borrower
      |> buildBorrower
      |> ifValid \case
        Left borrower -> render NewView {..}
        Right borrower -> do
          borrower <- borrower |> createRecord
          setSuccessMessage "Lånare skapad"
          redirectTo BorrowersAction
  action DeleteBorrowerAction {borrowerId} = do
    borrower <- fetch borrowerId
    deleteRecord borrower
    setSuccessMessage "Lånare borttagen"
    redirectTo BorrowersAction

buildBorrower borrower =
  borrower
    |> fill @["name", "cid", "email", "phone", "lastActive"]
    |> validateField #name nonEmpty
    |> validateField #cid nonEmpty
    |> validateField #email isEmail
