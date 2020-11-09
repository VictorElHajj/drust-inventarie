module Web.View.Borrowers.New where

import Web.View.Prelude

data NewView = NewView {borrower :: Borrower}

instance View NewView ViewContext where
  html NewView {..} =
    [hsx|
        {renderForm borrower}
    |]

renderForm :: Borrower -> Html
renderForm borrower =
  formFor
    borrower
    [hsx|
    <div class="p-4">
        <h3>Skapa ny lånare</h3>
        {(textField #name) {fieldLabel = "Namn"} {required = True}}
        {(textField #email) {fieldLabel = "E-post"} {required = True}}
        {(textField #phone) {fieldLabel = "Telefon"} {required = True}}
        {(dateField #lastActive) {fieldLabel = "Senaste lån"} {required = True}}
        {submitButton {label = "Spara"}}
    </div>
|]
