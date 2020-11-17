module Web.View.Tools.Index where

import Text.Blaze.Internal (MarkupM)
import Web.View.Prelude

data IndexView = IndexView {tools :: [Tool]}

instance View IndexView where
  html IndexView {..} =
    [hsx|
        <div class="table-responsive">
            <table class="table table-sm;" style="border-top:hidden;">
                <thead class="text-light" style="background-color: #fa6607;">
                <th style="width:15%;">Kategori</th>
                <th style="width:25%;">Namn</th>
                <th style="width:25%;">Beskrivning</th>
                <th style="width:15%;">Status</th>
                <th style="width:6%;"></th>
                <th style="width:6%;"></th>
                <th style="width:8%;"></th>
                </thead>
                {
                    let 
                        categories = map (get #category) tools
                            |> nub
                    in  
                        forEach categories (renderCategory tools)
                }
            </table>
        <a class="btn btn-light" href={NewToolAction} role="button">Ny</a>
        </div>
    |]

renderTool category tool =
  [hsx|
    <tr id={"collapseTool"++(trimSpaces category)} class="collapse" style="transition: none;">
        <td></td>
        <td>{get #name tool}</td>
        <td>{get #description tool}</td>
        <td>{get #status tool |> showSE}</td>
        {displayAdminOptions tool currentUserOrNothing}
    </tr>
|]

renderCategory tools category =
  [hsx|
    <tr style="transform: rotate(0);">
        <th>
            <a class="btn btn-link btn-block text-left text-dark stretched-link" data-toggle="collapse" data-target={"#collapseTool"++(trimSpaces category)} aria-expanded="false" aria-controls={trimSpaces category}>
            {category}
            </a>
        </th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    {
        let 
            toolsInCategory = filter (\tool -> (get #category tool) == category) tools
        in
            forEach toolsInCategory (renderTool category)
    }
|]

displayAdminOptions :: HasField "id" model (Id' "tools") => model -> Maybe User -> MarkupM ()
displayAdminOptions tool =
  \case
    (Just _) ->
      [hsx| 
        <td><a href={NewLoanAction (get #id tool)} class="text-muted">Låna</a></td>
        <td><a href={EditToolAction (get #id tool)} class="text-muted">Ändra</a></td>
        <td><a href={DeleteToolAction (get #id tool)} class="js-delete text-muted">Ta bort</a></td>
    |]
    Nothing ->
      [hsx| 
        <td></td>
        <td></td>
        <td></td>
    |]
