module Web.View.Borrowers.Index where

import Web.View.Prelude

data IndexView = IndexView {borrowers :: [Borrower]}

instance View IndexView ViewContext where
  html IndexView {..} =
    [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={BorrowersAction}>Borrowers</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewBorrowerAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Borrower</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach borrowers renderBorrower}</tbody>
            </table>
        </div>
    |]

renderBorrower borrower =
  [hsx|
    <tr>
        <td>{get #name borrower}</td>
        <td>{get #email borrower}</td>
        <td>{get #phone borrower}</td>
        <td>{get #lastActive borrower}</td>
        <td><a href={EditBorrowerAction (get #id borrower)} class="text-muted">Edit</a></td>
        <td><a href={DeleteBorrowerAction (get #id borrower)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
