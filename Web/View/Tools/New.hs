module Web.View.Tools.New where
import Web.View.Prelude

data NewView = NewView { tool :: Tool }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    <div class="mt-2">
        {(textField #category) {fieldLabel = "Kategori"} {required = True}}
        {(textField #name) {fieldLabel = "Namn"} {required = True}}
        {(textField #description) {fieldLabel = "Beskrivning"}}
        {submitButton {label = "Skapa Verktyg"}}
    </div>
|]
