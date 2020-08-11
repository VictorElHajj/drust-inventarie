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
                    tool <- tool |> updateRecord
                    setSuccessMessage "Tool updated"
                    redirectTo EditToolAction { .. }

    action CreateToolAction = do
        let tool = newRecord @Tool
        tool
            |> buildTool
            |> set #status "Tillgänglig"
            |> ifValid \case
                Left tool -> render NewView { .. } 
                Right tool -> do
                    tool <- tool |> createRecord
                    setSuccessMessage "Tool created"
                    redirectTo ToolsAction

    action DeleteToolAction { toolId } = do
        tool <- fetch toolId
        deleteRecord tool
        setSuccessMessage "Tool deleted"
        redirectTo ToolsAction

buildTool tool = tool
    |> fill @["category","name","description"]
