module Web.Controller.Loans where

import Data.Functor ((<&>))
import Web.Controller.Prelude
import Web.View.Loans.Edit
import Web.View.Loans.Index
import Web.View.Loans.New

instance Controller LoansController where
  beforeAction = ensureIsUser

  action LoansAction = do
    loans <- query @Loan |> fetch
    tools <- query @Tool |> fetch
    borrowers <- query @Borrower |> fetch
    render IndexView {..}
  action NewLoanAction {toolId} = do
    currentTime <-
      getCurrentTime
        <&> utctDay
    let loan =
          newRecord
            |> set #toolId toolId
            |> set #dateBorrowed currentTime
    tools <- query @Tool |> fetch
    borrowers <- query @Borrower |> fetch
    render NewView {..}
  action EditLoanAction {loanId} = do
    loan <- fetch loanId
    render EditView {..}
  action UpdateLoanAction {loanId} = do
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
    let loan = newRecord @Loan
    loan
      |> buildLoan
      |> ifValid \case
        Left loan -> do
          tools <- query @Tool |> fetch
          borrowers <- query @Borrower |> fetch
          render NewView {..}
        Right loan -> do
          let toolId = get #toolId loan
          tool <-
            fetch toolId
              <&> set #status Loaned
          tool |> updateRecord
          loan |> createRecord
          setSuccessMessage "Lån skapat"
          redirectTo LoansAction
  action DeleteLoanAction {loanId} = do
    loan <- fetch loanId
    deleteRecord loan
    setSuccessMessage "Lån borttaget"
    redirectTo LoansAction
  action ReturnLoanAction {loanId} = do
    currentTime <-
      getCurrentTime
        <&> utctDay
    loan <-
      fetch loanId
        <&> set #dateReturned (Just currentTime)
    loan |> updateRecord
    let toolId = get #toolId loan
    tool <-
      fetch toolId
        <&> set #status Available
    tool |> updateRecord
    setSuccessMessage "Verktyg återlämnat"
    redirectTo LoansAction

buildLoan loan =
  loan
    |> fill @["toolId", "borrowerId", "dateBorrowed", "dateReturned"]
