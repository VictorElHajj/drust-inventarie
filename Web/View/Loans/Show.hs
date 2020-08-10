module Web.View.Loans.Show where
import Web.View.Prelude

data ShowView = ShowView { loan :: Loan }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LoansAction}>Loans</a></li>
                <li class="breadcrumb-item active">Show Loan</li>
            </ol>
        </nav>
        <h1>Show Loan</h1>
    |]
