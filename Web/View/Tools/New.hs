module Web.View.Tools.New where
import Web.View.Prelude

data NewView = NewView { tool :: Tool }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ToolsAction}>Tools</a></li>
                <li class="breadcrumb-item active">New Tool</li>
            </ol>
        </nav>
        <h1>New Tool</h1>
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    {textField #category}
    {textField #name}
    {textField #description}
    {submitButton}
|]
