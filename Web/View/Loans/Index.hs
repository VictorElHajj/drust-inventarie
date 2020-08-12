{-# LANGUAGE LambdaCase #-}

module Web.View.Loans.Index where
import Web.View.Prelude

data IndexView = IndexView { loans :: [Loan]
                           , tools :: [Tool]
                           }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        <div class="table-responsive">
            <table class="table table-sm;" style="border-top:hidden;">
                <thead class="text-light" style="background-color: #fa6607;">
                    <tr>
                        <th>Verktyg</th>
                        <th>Person</th>
                        <th>Datum Lånat</th>
                        <th>Datum Lämnat</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach loans (renderLoan tools)}</tbody>
            </table>
        </div>
    |]


renderLoan tools loan = [hsx|
    <tr>
        <td>{
            let
                id = get #toolId loan
            in 
                find (\tool -> get #id tool == id) tools
                    |> \x -> case x of -- TODO: Why can't I use LambdaCase here?
                        Nothing -> "Verktyget finns inte"
                        Just tool -> name tool
            }</td>
        <td>{get #borrower loan}</td>
        <td>{get #dateBorrowed loan}</td>
        <td>{get #dateReturned loan}</td>
        <td><a href={EditLoanAction (get #id loan)} class="text-muted">Ändra</a></td>
        <td><a href={DeleteLoanAction (get #id loan)} class="js-delete text-muted">Ta bort</a></td>
    </tr>
|]
