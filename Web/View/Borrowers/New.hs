module Web.View.Borrowers.New where
import Web.View.Prelude

data NewView = NewView { borrower :: Borrower }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BorrowersAction}>Borrowers</a></li>
                <li class="breadcrumb-item active">New Borrower</li>
            </ol>
        </nav>
        <h1>New Borrower</h1>
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
