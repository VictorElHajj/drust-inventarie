module Web.View.Loans.Index where
import Web.View.Prelude

data IndexView = IndexView { loans :: [Loan] }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={LoansAction}>Loans</a></li>
            </ol>
        </nav>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Loan</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach loans renderLoan}</tbody>
            </table>
        </div>
    |]


renderLoan loan = [hsx|
    <tr>
        <td>{loan}</td>
        <td><a href={ShowLoanAction (get #id loan)}>Show</a></td>
        <td><a href={EditLoanAction (get #id loan)} class="text-muted">Edit</a></td>
        <td><a href={DeleteLoanAction (get #id loan)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
