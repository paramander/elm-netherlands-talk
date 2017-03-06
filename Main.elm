module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_, style)
import Html.Events exposing (on)
import Json.Decode as JD
import Ports exposing (ImagePortData, fileSelected, fileContentRead)


type Msg
    = ImageSelected
    | ImageRead ImagePortData


type alias Image =
    { contents : String
    , filename : String
    }


type alias Model =
    { id : String
    , mImage : Maybe Image
    }


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    { id = "ImageInputId"
    , mImage = Nothing
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ImageSelected ->
            model ! [ fileSelected model.id ]

        ImageRead portData ->
            let
                newImage =
                    { contents = portData.contents
                    , filename = portData.filename
                    }
            in
                { model | mImage = Just newImage }
                    ! []


view : Model -> Html Msg
view model =
    let
        imagePreview =
            case model.mImage of
                Just i ->
                    viewImagePreview model i

                Nothing ->
                    text ""
    in
        div [ class "imageWrapper" ]
            [ input
                [ type_ "file"
                , id model.id
                , on "change"
                    (JD.succeed ImageSelected)
                ]
                []
            , imagePreview
            ]


viewImagePreview : Model -> Image -> Html Msg
viewImagePreview model image =
    div
        [ style
            [ ( "position", "relative" )
            , ( "width", "500px" )
            , ( "height", "500px" )
            ]
        ]
        [ img
            [ src image.contents
            , title image.filename
            , style
                [ ( "width", "750px" )
                , ( "height", "500px" )
                ]
            ]
            []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ fileContentRead ImageRead ]
