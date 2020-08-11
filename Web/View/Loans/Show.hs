module Web.View.Loans.Show where
import Web.View.Prelude

data ShowView = ShowView { loan :: Loan }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <h1>Show Loan</h1>
    |]
