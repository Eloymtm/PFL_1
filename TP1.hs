import qualified Data.List
import qualified Data.Array
import qualified Data.Bits


-- PFL 2024/2025 Practical assignment 1

-- Uncomment the some/all of the first three lines to import the modules, do not change the code of these lines.

type City = String
type Path = [City]
type Distance = Int

type RoadMap = [(City,City,Distance)]
type AdjMatrix = Data.Array.Array (Int, Int) (Maybe Distance)


type AdjMatrix = Data.Array.Array (Int, Int) (Maybe Distance)

cities :: RoadMap -> [City]
cities r = Data.List.nub ([o| (o,_,_)<-r] ++ [p|(_,p,_)<-r])

areAdjacent :: RoadMap -> City -> City -> Bool
areAdjacent r c1 c2 = elem (c1,c2) [(x,y)|(x,y,_)<-r] || elem (c2,c1) [(x,y)|(x,y,_)<-r]

distance :: RoadMap -> City -> City -> Maybe Distance
distance r c1 c2 = case [d|(c,b,d)<-r,(c1,c2) == (c,b)|| (c2,c1) == (c,b)] of
    [] -> Nothing
    d:_ -> Just d

adjacent :: RoadMap -> City -> [(City,Distance)]
adjacent r c = [(c2, d)| (c1, c2,d)<- r, c1==c] ++ [(c1, d)| (c1, c2,d)<- r, c2==c]

pathDistance :: RoadMap -> Path -> Maybe Distance
pathDistance _ [] = Just 0
pathDistance _ [_] = Just 0
pathDistance r (c1:c2:xs) = case distance r c1 c2 of
    Nothing -> Nothing
    Just d -> case pathDistance r (c2:xs) of
        Nothing -> Nothing
        Just dt -> Just (d + dt)

rome :: RoadMap -> [City]
rome r = [c | (c, x) <- citiesDegrees, x == maximum[b | (_, b) <- citiesDegrees]]
    where citiesDegrees = [(c, fromIntegral (length (adjacent r c))) | c <- cities r]

dfs :: RoadMap -> [City] -> City -> [City]
dfs r v c
                    | c `elem` v = v
                    | otherwise = foldl (\acc adj -> dfs r acc adj) (c : v) adj
                where
                    adj = [adj | (adj, _) <- adjacent r c, adj `notElem` v]

bfs :: RoadMap -> [Path] -> [City] -> City -> [Path]
bfs r [] _ _ = [] 
bfs r (h:tl) v e 
      | c == e = h : bfs r tl v e 
      | otherwise = bfs r (tl ++ newPaths) (c : v) e
      where
        c = last h
        adj = getAdjacent c r
        newPaths = [h ++ [next] | next <- adj, next `notElem` v]

filterMinPaths :: [Path] -> RoadMap -> [Path]
filterMinPaths paths r =
    let distances = [d | Just d <- map (pathDistance r) paths]
    in case distances of
        [] -> []
        _  -> let minDist = minimum distances
              in [path | path <- paths, pathDistance r path == Just minDist]        

isStronglyConnected :: RoadMap -> Bool
isStronglyConnected r = allCities (cities r) True
                where
                    allCities :: [City] -> Bool -> Bool
                    allCities [] b = (b == True)
                    allCities (c1:cs) b = allCities cs (b && (length (dfs r [] c1) == length (cities r)))

getAdjacent :: City -> RoadMap -> [City]
getAdjacent city roads = [if c1 == city then c2 else c1 | (c1, c2, _) <- roads, c1 == city || c2 == city ]

shortestPath :: RoadMap -> City -> City -> [Path]
shortestPath r s e = filterMinPaths (bfs r [[s]] [] e) r
    

buildAdjMatrix :: [City] -> RoadMap -> AdjMatrix
buildAdjMatrix cities r =
    Data.Array.array bounds [((i, j), getDistance i j cities r) | i <- [0 .. numCities - 1], j <- [0 .. numCities - 1]]
  where
    numCities = length cities
    bounds = ((0, 0), (numCities - 1, numCities - 1))


getDistance :: Int -> Int -> [City] -> RoadMap -> Maybe Distance
getDistance i j cities r =
    let cityPairs = [((c1, c2), d) | (c1, c2, d) <- r] ++ [((c2, c1), d) | (c1, c2, d) <- r]
    in lookup (cities !! i, cities !! j) cityPairs

travelSales :: RoadMap -> Path
travelSales r
  | null citiesL = []
  | otherwise = case bestResult of
      Nothing -> []
      Just (_, path) -> map (citiesL !!) (0 : path)
  where
    citiesL = cities r
    numCities = length citiesL
    adjMatrix = buildAdjMatrix citiesL r


    buildMemoTable = Data.Array.array ((0, 0), (2 ^ numCities - 1, numCities - 1)) 
      [ ((visitedMask, pos), tsp visitedMask pos) 
      | visitedMask <- [0 .. 2 ^ numCities - 1], pos <- [0 .. numCities - 1]]


    tsp :: Int -> Int -> Maybe (Distance, [Int])
    tsp visitedMask pos
      | allCitiesVisited visitedMask = returnToStart
      | otherwise = findMinimum validMoves
      where
        allCitiesVisited mask = mask == (1 `Data.Bits.shiftL` numCities) - 1
        returnToStart = case adjMatrix Data.Array.! (pos, 0) of
                            Just distance -> Just (distance, [0])
                            Nothing -> Nothing

        validMoves = [ 
            let followingDist = adjMatrix Data.Array.! (pos, next)
            in case followingDist of
                Just d -> do
                    (existingDist, existingPath) <- buildMemoTable Data.Array.! 
                        (visitedMask Data.Bits..|. (1 `Data.Bits.shiftL` next), next)
                    Just (d + existingDist, next : existingPath)
                Nothing -> Nothing
            | next <- [0 .. numCities - 1],
            next /= pos,
            not (Data.Bits.testBit visitedMask next)
            ]   

    findMinimum :: [Maybe (Distance, [Int])] -> Maybe (Distance, [Int])
    findMinimum mvs =
      let validMvs = [v | Just v <- mvs]
      in case validMvs of
          [] -> Nothing
          _ -> Just $ Data.List.minimumBy comparePaths validMvs        

    comparePaths :: (Distance, [Int]) -> (Distance, [Int]) -> Ordering
    comparePaths (d1, _) (d2, _) = compare d1 d2

    bestResult = buildMemoTable Data.Array.! (1, 0)


tspBruteForce :: RoadMap -> Path
tspBruteForce = undefined -- only for groups of 3 people; groups of 2 people: do not edit this function

-- Some graphs to test your work
gTest1 :: RoadMap
gTest1 = [("7","6",1),("8","2",2),("6","5",2),("0","1",4),("2","5",4),("8","6",6),("2","3",7),("7","8",7),("0","7",8),("1","2",8),("3","4",9),("5","4",10),("1","7",11),("3","5",14)]

gTest2 :: RoadMap
gTest2 = [("0","1",10),("0","2",15),("0","3",20),("1","2",35),("1","3",25),("2","3",30)]

gTest3 :: RoadMap -- unconnected graph
gTest3 = [("0","1",4),("2","3",2)]
