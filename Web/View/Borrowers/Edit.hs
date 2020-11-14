module Web.View.Borrowers.Edit where

import Web.View.Prelude

data EditView = EditView {borrower :: Borrower}

instance View EditView where
  html EditView {..} =
    [hsx|
        {renderForm borrower}
    |]

renderForm :: Borrower -> Html
renderForm borrower =
  formFor
    borrower
    [hsx|
    <div class="p-4">
        <h3>Redigera lånare</h3>
        {(textField #name) {fieldLabel = "Namn"} {required = True}}
        {(textField #cid) {fieldLabel = "CID"} {required = True}}
        {(textField #email) {fieldLabel = "E-post"} {required = True}}
        {(textField #phone) {fieldLabel = "Telefon"} {required = True}}
        {submitButton {label = "Spara"}}
    </div>
|]
