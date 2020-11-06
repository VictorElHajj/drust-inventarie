module Web.Controller.Tools where

import Web.Controller.Prelude
import Web.View.Tools.Edit
import Web.View.Tools.Index
import Web.View.Tools.New

instance Controller ToolsController where
    action ToolsAction = do
        tools <- query @Tool |> fetch
        render IndexView { .. }

    action NewToolAction = do
        let tool = newRecord
        render NewView { .. }

    action EditToolAction { toolId } = do
        tool <- fetch toolId
        render EditView { .. }

    action UpdateToolAction { toolId } = do
        tool <- fetch toolId
        tool
            |> buildTool
            |> ifValid \case
                Left tool -> render EditView { .. }
                Right tool -> do
                    tool |> updateRecord
                    setSuccessMessage "Verktyg redigerat"
                    redirectTo ToolsAction

    action CreateToolAction = do
        let tool = newRecord @Tool
        tool
            |> buildTool
            |> set #status Available
            |> ifValid \case
                Left tool -> render NewView { .. } 
                Right tool -> do
                    tool |> createRecord
                    setSuccessMessage "Verktyg skapat"
                    redirectTo ToolsAction

    action DeleteToolAction { toolId } = do
        tool <- fetch toolId
        deleteRecord tool
        setSuccessMessage "Verktyg borttaget"
        redirectTo ToolsAction

buildTool tool = tool
    |> fill @["category","name","description", "status"]
