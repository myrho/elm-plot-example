import Plot
import Plot.Axis as Axis
import Plot.Label as Label
import Plot.Tick as Tick
import Plot.Bars as Bars
import Plot.Line as Line
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
      , Plot.margin (60,60,60,60)
      , Plot.padding (0, 40)
      , Plot.rangeLowest (always 0)
      , Plot.rangeHighest (always 2)
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
      , Plot.yAxis 
        [ Axis.line
          [ Line.stroke "black" ]
        ]
      , Plot.bars
        [ Bars.maxBarWidthPer 85
        ]
        [ [ Bars.fill "red" ]
        , [ Bars.fill "green" ]
        , [ Bars.fill "blue" ]
        ]
        <| Array.toList
        <| Array.indexedMap 
            (\i group ->
                (toFloat i, List.map .value group.units)
            )
            groups
      ]

