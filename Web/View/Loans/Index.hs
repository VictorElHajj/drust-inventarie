{-# LANGUAGE LambdaCase #-}

module Web.View.Loans.Index where

import Data.Text (pack)
import Text.Blaze.Internal (MarkupM)
import Web.View.Prelude

data IndexView = IndexView
  { loans :: [Loan],
    tools :: [Tool],
    borrowers :: [Borrower]
  }

instance View IndexView where
  html IndexView {..} =
    [hsx|
        <div class="table-responsive">
            <table class="table table-sm;" style="border-top:hidden;">
                <thead class="text-light" style="background-color: #fa6607;">
                    <tr>
                        <th>Verktyg</th>
                        <th>Person</th>
                        <th>Datum Lånat</th>
                        <th>Datum Retur</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                {
                    let 
                        activeLoans = filter isLoanActive loans
                            |> sortBy (\a b -> compare (get #dateBorrowed a) (get #dateBorrowed b))
                    in
                        renderCollapsableLoans False "Aktiva Lån" tools borrowers activeLoans
                }
                {
                    let 
                        inactiveLoans = filter (not . isLoanActive) loans
                            |> sortBy (\b a -> compare (get #dateReturned a) (get #dateReturned b))
                    in
                        renderCollapsableLoans True "Avklarade Lån" tools borrowers inactiveLoans
                }
                </tbody>
            </table>
        </div>
    |]

isLoanActive loan =
  get #dateReturned loan
    |> \case
      Just _ -> False
      Nothing -> True

renderCollapsableLoans collapsed title tools borrowers loans =
  [hsx|
    <tr style="transform: rotate(0);">
        <th>
            <a class="btn btn-link btn-block text-left text-dark stretched-link" data-toggle="collapse" data-target={"#collapse"++(trimSpaces title)} aria-expanded="false" aria-controls={trimSpaces title}>
            {title :: Text}
            </a>
        </th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    {
        forEach loans (renderLoan collapsed title tools borrowers)
    }
|]

collapse :: Bool -> Text
collapse = \case
  True -> pack ""
  False -> pack "show"

renderLoan collapsed title tools borrowers loan =
  [hsx|
    <tr id={"collapse"++(trimSpaces title)} class={"collapse "++(collapse collapsed)} style="transition: none;">
        <td>
        {
            let
                id = get #toolId loan
            in 
                find (\tool -> get #id tool == id) tools
                    |> \x -> case x of -- TODO: Why can't I use LambdaCase here?
                        Nothing -> "Verktyget finns inte"
                        Just tool -> name (tool :: Tool)
        }
        </td>
        <td>
        {
            let
                id = get #borrowerId loan
            in 
                find (\borrower -> get #id borrower == id) borrowers
                    |> \x -> case x of 
                        Nothing -> "Lånaren finns inte"
                        Just borrower -> name (borrower :: Borrower)
        }
        </td>
        <td>{get #dateBorrowed loan}</td>
        <td>{get #dateReturned loan}</td>
        {displayAdminOptions loan currentUserOrNothing}
    </tr>
|]

displayAdminOptions :: HasField "id" model (Id' "loans") => model -> Maybe User -> MarkupM ()
displayAdminOptions loan =
  \case
    (Just _) ->
      [hsx| 
        <td><a href={EditLoanAction (get #id loan)} class="text-muted">Ändra</a></td>
        <td><a href={ReturnLoanAction (get #id loan)} class="text-muted">Retur</a></td>
        <td><a href={DeleteLoanAction (get #id loan)} class="js-delete text-muted">Ta bort</a></td>
    |]
    Nothing ->
      [hsx| 
        <td></td>
        <td></td>
        <td></td>
    |]
