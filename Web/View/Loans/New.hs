module Web.View.Loans.New where
import Web.View.Prelude

data NewView = NewView { loan :: Loan
                       , tool :: Tool
                       }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LoansAction}>Loans</a></li>
                <li class="breadcrumb-item active">New Loan</li>
            </ol>
        </nav>
        <h1>New Loan</h1>
        {renderForm loan}
    |]

renderForm :: Loan -> Html
renderForm loan = formFor loan [hsx|
    {hiddenField #toolId}
    {textField #borrower}
    {textField #dateBorrowed}
    {submitButton}
|]
