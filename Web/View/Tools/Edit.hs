module Web.View.Tools.Edit where
import Web.View.Prelude

data EditView = EditView { tool :: Tool }

instance View EditView ViewContext where
    html EditView { .. } = [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    <div class="mt-2">
        <h2>Redigera verktyg</h2>
        {(textField #category) {fieldLabel = "Kategori"}}
        {(textField #name) {fieldLabel = "Namn"}}
        {(textField #description) {fieldLabel = "Beskrivning"}}
        {(textField #status) {fieldLabel = "Status"}}
        {submitButton {label = "Spara"}}
    </div>
|]
