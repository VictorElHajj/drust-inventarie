module Main where

import Config
import IHP.FrameworkConfig
import IHP.Job.Types
import IHP.Prelude
import IHP.RouterSupport
import qualified IHP.Server
import Web.FrontController
import Web.Types

instance Worker RootApplication where
  workers _ = []

instance FrontController RootApplication where
  controllers =
    [ mountFrontController WebApplication
    ]

main :: IO ()
main = IHP.Server.run config
