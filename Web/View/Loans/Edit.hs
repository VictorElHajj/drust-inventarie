module Web.View.Loans.Edit where
import Web.View.Prelude

data EditView = EditView { loan :: Loan }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LoansAction}>Loans</a></li>
                <li class="breadcrumb-item active">Edit Loan</li>
            </ol>
        </nav>
        <h1>Edit Loan</h1>
        {renderForm loan}
    |]

renderForm :: Loan -> Html
renderForm loan = formFor loan [hsx|
    {textField #toolId}
    {textField #borrower}
    {textField #dateBorrowed}
    {submitButton}
|]
