module Web.View.Users.Index where

import Web.View.Prelude

data IndexView = IndexView {user :: User}

instance View IndexView where
  html IndexView {..} =
    [hsx|
    <div class="p-4">
        <h3>Adminsida</h3>
        <a class="btn btn-light js-delete" href={DeletePIIAction} role="button">
          GDPR - Rensa alla lånare som inte har aktiva lån
        </a>
        <br>
        <a class="btn btn-light" href={EditUserAction (get #id user)} role="button">
          Byt lösenord på DRusts konto
        </a>
    </div>
    |]
