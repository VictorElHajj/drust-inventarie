module Web.View.Layout (defaultLayout, Html) where

import Config ()
import Generated.Types (User)
import IHP.Environment
import qualified IHP.FrameworkConfig as FrameworkConfig
import IHP.LoginSupport.Helper.View (currentUser, currentUserOrNothing)
import IHP.ViewPrelude
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Internal (MarkupM)
import Web.Routes
import Web.Types

defaultLayout :: Html -> Html
defaultLayout inner =
  H.docTypeHtml ! A.lang "en" $
    [hsx|
<head>
    {metaTags}

    {stylesheets}
    {scripts}

    <title>DRust</title>
</head>
<body>
    {renderFlashMessages}
    <div class="container mt-4">
        <nav class="navbar navbar-dark navbar-expand shadow" style={backgroundColor currentUserOrNothing}>
            <a class="navbar-brand" href="/">
                <img src="/Drust20.png" width="50" height="50" alt="">
            </a>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item ">
                    <a class={classes ["nav-link", ("active", isActivePath ToolsAction)]} data-turbolinks="false" href={ToolsAction}>Verktyg</a>
                </li>
                {displayLoans currentUserOrNothing (isActivePath LoansAction)}
                {displayBorrower currentUserOrNothing (isActivePath BorrowersAction)}
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    {displayAdmin currentUserOrNothing}
                </li>
                <li class="nav-item">
                    {loginOrLogout currentUserOrNothing}
                </li>
            </ul>
        </nav>
        <div class="shadow">
            {inner}
        </div>
    </div>
</body>
|]

stylesheets :: Html
stylesheets = do
  when
    isDevelopment
    [hsx|
        <link rel="stylesheet" href="/vendor/bootstrap.min.css"/>
        <link rel="stylesheet" href="/vendor/flatpickr.min.css"/>
        <link rel="stylesheet" href="/app.css"/>
    |]
  when
    isProduction
    [hsx|
        <link rel="stylesheet" href="/prod.css"/>
    |]

scripts :: Html
scripts = do
  when
    isDevelopment
    [hsx|
        <script id="livereload-script" src="/livereload.js"></script>
        <script src="/vendor/jquery-3.6.0.slim.min.js"></script>
        <script src="/vendor/timeago.js"></script>
        <script src="/vendor/popper.min.js"></script>
        <script src="/vendor/bootstrap.min.js"></script>
        <script src="/vendor/flatpickr.js"></script>
        <script src="/helpers.js"></script>
        <script src="/vendor/morphdom-umd.min.js"></script>
    |]
  when
    isProduction
    [hsx|
        <script src="/prod.js"></script>
    |]

metaTags :: Html
metaTags =
  [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="DRust Inventariesystem"/>
    <meta property="og:description" content="DRust Inventariesystem"/>
|]

backgroundColor :: Maybe User -> String
backgroundColor = \case
  (Just _) -> "background-color: #CD0000;" -- Röda färgen på sovjetflaggan
  Nothing -> "background-color: #FA6607;" -- Sektionsfärg

loginOrLogout :: Maybe User -> MarkupM ()
loginOrLogout (Just _) =
  [hsx|
  <a class={classes ["nav-link", "js-delete", "js-delete-no-confirm"]} href={DeleteSessionAction}> Logga ut </a>
|]
loginOrLogout (Nothing) =
  [hsx|
  <a class={classes ["nav-link"]} href={NewSessionAction}> Logga in som DRust </a>
|]

displayAdmin :: Maybe User -> MarkupM ()
displayAdmin (Just _) =
  [hsx|
  <a class={classes ["nav-link"]} href={UserAction}>Adminsida</a>
|]
displayAdmin (Nothing) =
  [hsx|
  |]

displayGDPR :: Maybe User -> MarkupM ()
displayGDPR (Just _) =
  [hsx|
   <a href={DeletePIIAction} class="js-delete nav-link">GDPR</a>
|]
displayGDPR (Nothing) =
  [hsx|
  |]

displayLoans :: Maybe User -> Bool -> MarkupM ()
displayLoans (Just _) isActive =
  [hsx|
    <a class={classes ["nav-link", ("active", isActive)]} data-turbolinks="false" href={LoansAction}>Lån</a>
|]
displayLoans (Nothing) _ =
  [hsx|
  |]

displayBorrower :: Maybe User -> Bool -> MarkupM ()
displayBorrower (Just _) isActive =
  [hsx|
    <a class={classes ["nav-link", ("active", isActive)]} data-turbolinks="false" href={BorrowersAction}>Lånare</a>
|]
displayBorrower (Nothing) _ =
  [hsx|
  |]
