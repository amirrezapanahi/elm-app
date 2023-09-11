module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, span)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Yay =
  { name : String
  , init : Int
  }

type alias Model = Yay

init : Model
init = { name = "P hunch", init = 0 }

-- UPDATE
type Msg
  = Increment
  | Decrement
  
shakeStyle : Model -> List (Html.Attribute Msg)
shakeStyle model =
    if model.init == 0 then
        List.map (\(k, v) -> style k v) 
            [ ("animation", "shake 0.3s cubic-bezier(.36,.07,.19,.97) both")
            , ("color", "red")
            ]
    else
        []

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | init = model.init + 1, name = model.name ++ "o" }

    Decrement ->
      if model.init == 0 then
        model
      else
        let
          newName = String.slice 0 (String.length model.name - 1) model.name
        in
          { model | init = model.init - 1, name = newName }

-- VIEW
view : Model -> Html Msg
view model =
  div [ style "display" "flex", style "flex-direction" "column", style "align-items" "center", style "margin-top" "20px" ]
    [ button [ onClick Decrement, style "width" "50px", style "height" "50px", style "font-size" "24px", style "margin" "5px" ] [ text "-" ]
    , span ([ style "font-size" "32px", style "margin" "10px" ] ++ shakeStyle model) [ text (String.fromInt model.init) ]
    , button [ onClick Increment, style "width" "50px", style "height" "50px", style "font-size" "24px", style "margin" "5px" ] [ text "+" ]
    , div [ style "font-size" "20px", style "margin" "10px" ] [ text model.name ]
    ]


