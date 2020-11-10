module Web.View.Borrowers.Index where

import Web.View.Prelude

data IndexView = IndexView {borrowers :: [Borrower]}

instance View IndexView ViewContext where
  html IndexView {..} =
    [hsx|
        <div class="table-responsive">
            <table class="table table-sm;" style="border-top:hidden;">
                <thead class="text-light" style="background-color: #fa6607;">
                    <tr>
                        <th>Lånare</th>
                        <th>E-post</th>
                        <th>Telefon</th>
                        <th>Senaste lån</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                {
                    let 
                        sortedBorrowers = sortBy ((flip compare) `on` (get #lastActive)) borrowers
                    in
                        forEach sortedBorrowers renderBorrower
                }   
                </tbody>
            </table>
            <a class="btn btn-light" href={NewBorrowerAction} role="button">Ny</a>
        </div>
    |]

renderBorrower borrower =
  [hsx|
    <tr>
        <td>{get #name borrower <> " - " <> get #cid borrower}</td>
        <td>{get #email borrower}</td>
        <td>{get #phone borrower}</td>
        <td>{get #lastActive borrower}</td>
        <td><a href={EditBorrowerAction (get #id borrower)} class="text-muted">Ändra</a></td>
        <td><a href={DeleteBorrowerAction (get #id borrower)} class="js-delete text-muted">Ta bort</a></td>
    </tr>
|]
