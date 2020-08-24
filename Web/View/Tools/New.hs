module Web.View.Tools.New where
import Web.View.Prelude

data NewView = NewView { tool :: Tool }

instance View NewView ViewContext where
    html NewView { .. } = [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool = formFor tool [hsx|
    <div class="p-4">
        <h3>Nytt verktyg</h3>
        {(textField #category) {fieldLabel = "Kategori"} {required = True}}
        {(textField #name) {fieldLabel = "Namn"} {required = True}}
        {(textField #description) {fieldLabel = "Beskrivning"}}
        {submitButton {label = "Skapa Verktyg"}}
    </div>
|]
