module Web.View.Borrowers.Edit where
import Web.View.Prelude

data EditView = EditView { borrower :: Borrower }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BorrowersAction}>Borrowers</a></li>
                <li class="breadcrumb-item active">Edit Borrower</li>
            </ol>
        </nav>
        <h1>Edit Borrower</h1>
        {renderForm borrower}
    |]

renderForm :: Borrower -> Html
renderForm borrower = formFor borrower [hsx|
    {(textField #name)}
    {(textField #email)}
    {(textField #phone)}
    {(textField #lastActive)}
    {submitButton}
|]
