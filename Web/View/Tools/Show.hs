module Web.View.Tools.Show where
import Web.View.Prelude

data ShowView = ShowView { tool :: Tool }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ToolsAction}>Tools</a></li>
                <li class="breadcrumb-item active">Show Tool</li>
            </ol>
        </nav>
        <h1>Show Tool</h1>
    |]
