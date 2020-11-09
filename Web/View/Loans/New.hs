module Web.View.Loans.New where

import Web.View.Prelude

data NewView = NewView
  { loan :: Loan,
    tools :: [Tool],
    borrowers :: [Borrower]
  }

instance View NewView ViewContext where
  html NewView {..} =
    [hsx|
        {renderForm tools borrowers loan}
    |]

renderForm :: [Tool] -> [Borrower] -> Loan -> Html
renderForm tools borrowers loan =
  formFor
    loan
    [hsx|
    <div class="p-4">
        <h3>Nytt lån</h3>
        {(selectField #toolId tools) {fieldLabel = "Verktyg"} {required = True} {placeholder = "Välj ett"}}
        {(selectField #borrowerId borrowers) {fieldLabel = "Lånare"} {required = True} {placeholder = "Välj en"}}
        {(dateField #dateBorrowed) {fieldLabel = "Datum utlånat"} {required = True}}
        {submitButton {label = "Skapa Lån"}}
    </div>
|]

instance CanSelect Tool where
  type SelectValue Tool = Id Tool
  selectValue = get #id
  selectLabel = \m -> (get #category m) <> " - " <> (get #name m)

instance CanSelect Borrower where
  type SelectValue Borrower = Id Borrower
  selectValue = get #id
  selectLabel = get #name
