module Web.View.Loans.Edit where
import Web.View.Prelude

data EditView = EditView { loan :: Loan }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        {renderForm loan}
    |]

renderForm :: Loan -> Html
renderForm loan = formFor loan [hsx|
    <div class="p-4">
        <h3>Redigera lån</h3>
        {textField #toolId}
        {textField #borrower}
        {textField #dateBorrowed}
        {submitButton}
    </div>
|]
