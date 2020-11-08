module Web.Controller.Loans where

import Data.Functor ((<&>))
import Web.Controller.Prelude
import Web.View.Loans.Edit
import Web.View.Loans.Index
import Web.View.Loans.New

instance Controller LoansController where
  action LoansAction = do
    loans <- query @Loan |> fetch
    tools <- query @Tool |> fetch
    render IndexView {..}
  action NewLoanAction {toolId} = do
    ensureIsUser
    currentTime <-
      getCurrentTime
        <&> utctDay
    let loan =
          newRecord
            |> set #toolId toolId
            |> set #dateBorrowed currentTime
    tools <- query @Tool |> fetch
    render NewView {..}
  action EditLoanAction {loanId} = do
    ensureIsUser
    loan <- fetch loanId
    render EditView {..}
  action UpdateLoanAction {loanId} = do
    ensureIsUser
    loan <- fetch loanId
    loan
      |> buildLoan
      |> ifValid \case
        Left loan -> render EditView {..}
        Right loan -> do
          loan |> updateRecord
          setSuccessMessage "Lån redigerat"
          redirectTo LoansAction
  action CreateLoanAction = do
    ensureIsUser
    let loan = newRecord @Loan
    loan
      |> buildLoan
      |> ifValid \case
        Left loan -> do
          tools <- query @Tool |> fetch
          render NewView {..}
        Right loan -> do
          loan |> createRecord
          setSuccessMessage "Lån skapat"
          redirectTo LoansAction
  action DeleteLoanAction {loanId} = do
    ensureIsUser
    loan <- fetch loanId
    deleteRecord loan
    setSuccessMessage "Lån borttaget"
    redirectTo LoansAction

buildLoan loan =
  loan
    |> fill @["toolId", "borrower", "dateBorrowed", "dateReturned"]
