import qualified Data.List
import qualified Data.Array
import qualified Data.Bits


-- PFL 2024/2025 Practical assignment 1

-- Uncomment the some/all of the first three lines to import the modules, do not change the code of these lines.

type City = String
type Path = [City]
type Distance = Int

type RoadMap = [(City,City,Distance)]

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

route :: RoadMap -> City -> Int
route r c = length (adjacent r c)

dfs :: RoadMap -> [City] -> City -> [City]
dfs r v c
                    | c `elem` v = v
                    | otherwise = foldl (\acc adj -> dfs r acc adj) (c : v) adj
                where
                    adj = [adj | (adj, _) <- adjacent r c, adj `notElem` v]

bfs :: RoadMap -> [Path] -> [City] -> City -> [Path]
bfs r [] _ _ = [] 
bfs r (h:tl) v e
      | c == e = [h]  
      | otherwise = bfs r (tl ++ newPaths) (c : v) e
      where
        c = last h
        adj = getAdjacent c r
        newPaths = [h ++ [next] | next <- adj, next `notElem` v]

isStronglyConnected :: RoadMap -> Bool
isStronglyConnected r =
                        let c1 = head allCities                 
                            visitedCities = dfs r [] c1         
                        in length visitedCities == length allCities    
                    where
                        allCities = cities r                      

getAdjacent :: City -> RoadMap -> [City]
getAdjacent city roads = [if c1 == city then c2 else c1 | (c1, c2, _) <- roads, c1 == city || c2 == city ]

shortestPath :: RoadMap -> City -> City -> [Path]
shortestPath r s e = bfs r [[s]] [] e
    

travelSales :: RoadMap -> Path
travelSales = undefined

tspBruteForce :: RoadMap -> Path
tspBruteForce = undefined -- only for groups of 3 people; groups of 2 people: do not edit this function

-- Some graphs to test your work
gTest1 :: RoadMap
gTest1 = [("7","6",1),("8","2",2),("6","5",2),("0","1",4),("2","5",4),("8","6",6),("2","3",7),("7","8",7),("0","7",8),("1","2",8),("3","4",9),("5","4",10),("1","7",11),("3","5",14)]

gTest2 :: RoadMap
gTest2 = [("0","1",10),("0","2",15),("0","3",20),("1","2",35),("1","3",25),("2","3",30)]

gTest3 :: RoadMap -- unconnected graph
gTest3 = [("0","1",4),("2","3",2)]
