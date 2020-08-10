module Web.View.Tools.Index where
import Web.View.Prelude

data IndexView = IndexView { tools :: [Tool] }

instance View IndexView ViewContext where
    html IndexView { .. } = [hsx|
        <div class="table-responsive">
             <table class="table table-striped table-hover table-borderless">
                <thead class="text-light" style="background-color: #fa6607;">
                    <tr>
                        <th>Kategori</th>
                        <th>Namn</th>
                        <th>Beskrivning</th>
                        <th>Status</th>
                        <th> </th>
                        <th> </th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>{forEach tools renderTool}</tbody>
            </table>
            <a class="btn btn-light" href={NewToolAction} role="button">Ny</a>
        </div>
    |]


renderTool tool = [hsx|
    <tr>
        <td>{get #category tool}</td>
        <td>{get #name tool}</td>
        <td>{get #description tool}</td>
        <td>{get #status tool}</td>
        <td><a href={NewLoanAction (get #id tool)} class="text-muted">Låna</a></td>
        <td><a href={EditToolAction (get #id tool)} class="text-muted">Ändra</a></td>
        <td><a href={DeleteToolAction (get #id tool)} class="js-delete text-muted">Ta bort</a></td>
    </tr>
|]
