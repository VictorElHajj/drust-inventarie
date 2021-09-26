module Web.View.Tools.Index where

import Text.Blaze.Internal (MarkupM)
import Web.View.Prelude

data IndexView = IndexView {tools :: [Tool]}

instance View IndexView where
  html IndexView {..} =
    [hsx|
        <div class = "p-2" style="background-color: #fa6607;">
        <input id="toolSearch" type="text" placeholder="Sök verktyg "onkeyup="searchTool()">
        <script>
            function searchTool() {
                searchFor = document.getElementById("toolSearch");
                filter = searchFor.value.toUpperCase();
                table = document.getElementById("toolTable");
                tr = table.getElementsByTagName("tr"); 
                for (i = 0; i < tr.length; i++) {
                    if (tr[i].id == "categoryHeader") {continue;}
                    td = tr[i].getElementsByTagName("td")[1];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].className = "collapse show";
                        } else {
                            tr[i].className = "collapse";
                        }
                    }
                }
            }
        </script>
        </div>
        <div class="table-responsive">
            <table id="toolTable" class="table table-sm;" style="border-top:hidden;">
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
    <tr id={"collapseTool"++(trimSpaces category)} class="collapse show" style="transition: none;">
        <td></td>
        <td>{get #name tool}</td>
        <td>{get #description tool}</td>
        <td>{get #status tool |> showSE}</td>
        {displayAdminOptions tool currentUserOrNothing}
    </tr>
|]

renderCategory tools category =
  [hsx|
    <tr id="categoryHeader" style="transform: rotate(0);">
        <th>
            <a class="text-left text-dark">
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
