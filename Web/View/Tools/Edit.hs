module Web.View.Tools.Edit where
import Web.View.Prelude

data EditView = EditView { tool :: Tool }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ToolsAction}>Tools</a></li>
                <li class="breadcrumb-item active">Edit Tool</li>
            </ol>
        </nav>
        <h1>Edit Tool</h1>
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    {textField #category}
    {textField #name}
    {textField #status}
    {submitButton}
|]
