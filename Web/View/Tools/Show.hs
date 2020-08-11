module Web.View.Tools.Show where
import Web.View.Prelude

data ShowView = ShowView { tool :: Tool }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <h1>Show Tool</h1>
    |]
