module Web.View.Borrowers.Show where
import Web.View.Prelude

data ShowView = ShowView { borrower :: Borrower }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BorrowersAction}>Borrowers</a></li>
                <li class="breadcrumb-item active">Show Borrower</li>
            </ol>
        </nav>
        <h1>Show Borrower</h1>
        <p>{borrower}</p>
    |]
