module Web.View.Tools.Index where
import Web.View.Prelude

data IndexView = IndexView { tools :: [Tool] }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        <div class="table-responsive">
            <table class="table table-sm">
                {
                    let 
                        categories = map (get #category) tools
                            |> nub
                    in  
                        forEach categories (renderCategory tools)
                }
            </table>
        </div>
        <a class="btn btn-light" href={NewToolAction} role="button">Ny</a>
    |]


renderTool tool = [hsx|
    <tr>
        <td>{get #name tool}</td>
        <td>{get #description tool}</td>
        <td>{get #status tool}</td>
        <td><a href={NewLoanAction (get #id tool)} class="text-muted">Låna</a></td>
        <td><a href={EditToolAction (get #id tool)} class="text-muted">Ändra</a></td>
        <td><a href={DeleteToolAction (get #id tool)} class="js-delete text-muted">Ta bort</a></td>
    </tr>
|]

renderCategory tools category = [hsx|
    <tr>
        <td>
            <button class="btn btn-link btn-block text-left text-dark" data-toggle="collapse" data-target={"#"++category} aria-expanded="false" aria-controls={category}>
            {category}
            </button>
            <div id={category} class="collapse" aria-labelledby="headingOne">
                <table class="table table-striped table-hover table-borderless">
                <thead class="thead-light">
                    <th>Namn</th>
                    <th>Beskrivning</th>
                    <th>Status</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </thead>
                    <tbody>
                        {
                            let 
                                toolsInCategory = filter (\tool -> (get #category tool) == category) tools
                            in
                                forEach toolsInCategory renderTool
                        }
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
|]
