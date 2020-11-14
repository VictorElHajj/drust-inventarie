module Web.View.Tools.Edit where

import qualified IHP.NameSupport
import qualified Text.Blaze.Html5 as Html5
import Web.View.Prelude

data EditView = EditView {tool :: Tool}

instance View EditView where
  html EditView {..} =
    [hsx|
        {renderForm tool}
    |]

renderForm :: Tool -> Html
renderForm tool =
  formFor
    tool
    [hsx|
    <div class="p-4">
        <h3>Redigera verktyg</h3>
        {(textField #category) {fieldLabel = "Kategori"}}
        {(textField #name) {fieldLabel = "Namn"}}
        {(textField #description) {fieldLabel = "Beskrivning"}}
        {selectEnum (listSE :: [Status])}
        {submitButton {label = "Spara"}}
    </div>
|]

selectEnum :: (Show enum, SqlEnum enum) => [enum] -> Html
selectEnum enums =
  [hsx|
<div class="form-group" id="form-group-tool_status">
    <label class="" for="tool_status">Status</label>
    <select class="custom-select form-control" name="status">
        {forEach enums renderEnum}
    </select>
</div>
|]
  where
    renderEnum enum =
      [hsx|
        <option value={show enum |> toLower}>{showSE enum}</option>
    |]
