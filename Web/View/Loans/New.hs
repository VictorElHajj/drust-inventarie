module Web.View.Loans.New where

import Web.View.Prelude

data NewView = NewView
  { loan :: Loan,
    tools :: [Tool]
  }

instance View NewView ViewContext where
  html NewView {..} =
    [hsx|
        {renderForm tools loan}
    |]

renderForm :: [Tool] -> Loan -> Html
renderForm tools loan =
  formFor
    loan
    [hsx|
    <div class="p-4">
        <h3>Nytt lån</h3>
        {(selectField #toolId tools) {fieldLabel = "Verktyg"} {required = True} {placeholder = "Välj ett"}}
        {(textField #borrower) {fieldLabel = "Lånare"} {required = True}}
        {(dateField #dateBorrowed) {fieldLabel = "Datum utlånat"} {required = True}}
        {submitButton {label = "Skapa Lån"}}
    </div>
|]

instance CanSelect Tool where
  type SelectValue Tool = Id Tool
  selectValue = get #id
  selectLabel = \m -> (get #category m) <> " - " <> (get #name m)
