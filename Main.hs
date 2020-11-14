module Main where

import Config
import IHP.FrameworkConfig
import IHP.Prelude
import IHP.RouterSupport
import qualified IHP.Server
import Web.FrontController
import Web.Types

instance FrontController RootApplication where
  controllers =
    [ mountFrontController WebApplication
    ]

main :: IO ()
main = IHP.Server.run config
