module Web.View.Loans.New where
import Web.View.Prelude

data NewView = NewView { loan :: Loan
                       , tool :: Tool
                       }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        {renderForm loan}
    |]

renderForm :: Loan -> Html
renderForm loan = formFor loan [hsx|
    {hiddenField #toolId}
    {textField #borrower}
    {textField #dateBorrowed}
    {submitButton}
|]
