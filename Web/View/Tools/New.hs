module Web.View.Tools.New where
import Web.View.Prelude

data NewView = NewView { tool :: Tool }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    {textField #category}
    {textField #name}
    {textField #description}
    {submitButton}
|]
