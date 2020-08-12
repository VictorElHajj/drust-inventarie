module Web.Controller.Loans where

import Web.Controller.Prelude
import Web.View.Loans.Index
import Web.View.Loans.New
import Web.View.Loans.Edit

instance Controller LoansController where
    action LoansAction = do
        loans <- query @Loan |> fetch
        tools <- query @Tool |> fetch
        render IndexView { .. }

    action NewLoanAction { toolId }= do
        let loan = newRecord
                |> set #toolId toolId
        tool <- fetch toolId
        render NewView { .. }

    action EditLoanAction { loanId } = do
        loan <- fetch loanId
        render EditView { .. }

    action UpdateLoanAction { loanId } = do
        loan <- fetch loanId
        loan
            |> buildLoan
            |> ifValid \case
                Left loan -> render EditView { .. }
                Right loan -> do
                    loan <- loan |> updateRecord
                    setSuccessMessage "Loan updated"
                    redirectTo EditLoanAction { .. }

    action CreateLoanAction = do
        let loan = newRecord @Loan
        loan
            |> buildLoan
            |> ifValid \case
                Left loan -> do
                    tool <- fetch (get #toolId loan) 
                    render NewView { .. } 
                Right loan -> do
                    loan <- loan |> createRecord
                    setSuccessMessage "Loan created"
                    redirectTo LoansAction

    action DeleteLoanAction { loanId } = do
        loan <- fetch loanId
        deleteRecord loan
        setSuccessMessage "Loan deleted"
        redirectTo LoansAction

buildLoan loan = loan
    |> fill @["toolId","borrower","dateBorrowed"]
