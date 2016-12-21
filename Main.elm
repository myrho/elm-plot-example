import Plot
import Plot.Axis as Axis
import Plot.Label as Label
import Plot.Pile as Pile
import Plot.Tick as Tick
import Array

type alias Group =
  { name : String
  , units : List Unit
  }

type alias Unit =
  { label : String
  , value : Float
  }

groups =
  Array.fromList
    [ Group "group1" 
      [ Unit "u1" 23.5 
      , Unit "u2" 27.8 
      , Unit "u3" 10.3 
      ]
    , Group "group2" 
      [ Unit "v1" 13.9 
      , Unit "v2" 12.0 
      , Unit "v3" 8.1 
      ]
    , Group "group3" 
      [ Unit "w1" 15.9 
      , Unit "w2" 15.4 
      , Unit "w3" 18.2 
      ]
    ]

main =
    Plot.plot
      [ Plot.size (800,600)
      , Plot.padding (30,30)
      ]
      [ Plot.horizontalGrid [ ]
      , Plot.xAxis 
        [ Axis.tick
            [ Tick.delta 1
            ]
        , Axis.label
          [ Label.view
            [ Label.format
              (\(i, _) -> 
                Array.get i groups
                  |> Maybe.map .name
                  |> Maybe.withDefault ""
              )
            ]
          ]
        ]
      , Plot.pile
        [ ]
        <| Array.toList
        <| Array.map 
            (\group ->
              Pile.bars
                [ --Bars.label (\y -> Svg.text_ [] [ Svg.text <| toString y ])
                ]
                <| List.indexedMap 
                    (\i unit ->
                      (toFloat i, unit.value)
                    )
                    group.units
            )
            groups
      ]

