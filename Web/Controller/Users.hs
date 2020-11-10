module Web.Controller.Users where

import Data.Functor ((<&>))
import Web.Controller.Prelude
import Web.View.Users.Edit
import Web.View.Users.Index

instance Controller UsersController where
  beforeAction = ensureIsUser
  action UserAction = do
    user <- fetch currentUserId
    render IndexView {..}
  action EditUserAction {userId} = do
    user :: User <-
      fetch userId
        <&> set #passwordHash ""
    render EditView {..}
  action UpdateUserAction {userId} = do
    user <- fetch userId
    user
      |> buildUser
      |> ifValid \case
        Left user -> render EditView {..}
        Right user -> do
          hashedPassword <- hashPassword (get #passwordHash user)
          user
            |> set #passwordHash hashedPassword
            |> updateRecord
          setSuccessMessage "Lösenord bytt"
          redirectTo UserAction

buildUser user =
  user
    |> fill @["email", "passwordHash", "failedLoginAttempts"]
