module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (..)
import Time exposing (..)
import Date exposing (..)
import String exposing (padLeft)


dateTime : Signal Date
dateTime =
  Signal.map fromTime <| every Time.second


padWith : Char -> a -> String
padWith c =
  padLeft 2 c << toString


colorFormat : Date -> String
colorFormat d =
  "#"
    ++ (Date.hour d |> padWith '0')
    ++ (Date.minute d |> padWith '0')
    ++ (Date.second d |> padWith '0')


view : Date -> Html
view d =
  let
    c =
      colorFormat d
  in
    div
      [ class "background", style [ ( "background-color", c ) ] ]
      [ div
          [ class "absolute-center" ]
          [ div
              [ class "time" ]
              [ text (colorFormat d) ]
          ]
      , div
          [ class "footer" ]
          [ text "A "
          , a
              [ href "https://en.wikipedia.org/wiki/Web_colors#Hex_triplet"
              , target "_blank"
              ]
              [ text "hexclock" ]
          , text " in "
          , a
              [ href "http://elm-lang.org"
              , target "_blank"
              ]
              [ text "elm" ]
          , text " by "
          , a
              [ href "https://twitter.com/irrwitz"
              , class "button"
              , target "_blank"
              ]
              [ text "@irrwitz" ]
          ]
      ]


main =
  Signal.map view dateTime
