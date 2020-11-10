module Web.View.Users.Edit where

import Web.View.Prelude

data EditView = EditView {user :: User}

instance View EditView ViewContext where
  html EditView {..} =
    [hsx|
        {renderForm user}
    |]

renderForm :: User -> Html
renderForm user =
  formFor
    user
    [hsx|
    <div class="p-4">
        <h3>Byt lösenord</h3>
        {(hiddenField #email) {fieldLabel = "E-post"} {required = True}}
        {(passwordField #passwordHash) {fieldLabel = "Nytt lösenord"} {placeholder = ""}}
        {(hiddenField #failedLoginAttempts)}
        {submitButton {label = "Spara"}}
    </div>
|]
