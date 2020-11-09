module Web.View.Loans.Edit where

import Web.View.Prelude

data EditView = EditView {loan :: Loan}

instance View EditView ViewContext where
  html EditView {..} =
    [hsx|
        {renderForm loan}
    |]

renderForm :: Loan -> Html
renderForm loan =
  formFor
    loan
    [hsx|
    <div class="p-4">
        <h3>Redigera lån</h3>
        {hiddenField #toolId}
        {(textField #borrower) {fieldLabel = "Lånare"} {required = True}}
        {(dateField #dateBorrowed) {fieldLabel = "Datum Lånat"} {required = True}}
        {(dateField #dateReturned) {fieldLabel = "Datum Retur"}}
        {submitButton {label = "Spara"}}
    </div>
|]
