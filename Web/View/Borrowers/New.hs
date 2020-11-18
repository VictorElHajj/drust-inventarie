module Web.View.Borrowers.New where

import Web.View.Prelude

data NewView = NewView {borrower :: Borrower}

instance View NewView where
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
        {(textField #name) {fieldLabel = "Fullständigt namn"} {required = True}}
        {(textField #cid) {fieldLabel = "CID"} {required = True}}
        {(textField #email) {fieldLabel = "E-post"} {required = True}}
        {(textField #phone) {fieldLabel = "Telefon"} {required = True}}
        {(checkboxField #gdprConsent) {fieldLabel = "GDPR: Jag godkänner att DRust sparar denna data tills att nästa DRust går på och alla lånade verktyg är tillbaka. Personuppgifterna sparas så att vi kan nå er ifall ett verktyg ej lämnas tillbaka i rimlig tid."
} {required = True}}
        {submitButton {label = "Spara"}}
    </div>
|]
