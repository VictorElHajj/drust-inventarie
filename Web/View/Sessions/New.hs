module Web.View.Sessions.New where

import IHP.AuthSupport.View.Sessions.New
import Web.View.Prelude

instance View (NewView User) ViewContext where
  html NewView {..} =
    [hsx|
        <div class="h-100 p-4" id="sessions-new">
            <div class="d-flex align-items-center">
                <div class="w-100">
                    <div style="max-width: 400px" class="mx-auto mb-5">
                        {renderFlashMessages}
                        <h3>Logga in som DRust</h3>
                        {renderForm user}
                    </div>
                </div>
            </div>
        </div>
    |]

renderForm :: User -> Html
renderForm user =
  [hsx|
    <form method="POST" action={CreateSessionAction}>
        <div class="form-group">
            <input name="email" value={get #email user} type="email" class="form-control" placeholder="E-Post"/>
        </div>
        <div class="form-group">
            <input name="password" type="password" class="form-control" placeholder="Lösenord"/>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Login</button>
    </form>
|]
