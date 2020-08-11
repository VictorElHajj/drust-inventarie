module Web.View.Tools.Edit where
import Web.View.Prelude

data EditView = EditView { tool :: Tool }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    {textField #category}
    {textField #name}
    {textField #status}
    {submitButton}
|]
