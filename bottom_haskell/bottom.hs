module Main where

type Graph = [[Int]]

type Node = Int

type Edges = [Int]

type Sink = Int

type Sinks = [Sink]

main = interact withIO
    where
        withIO :: String -> String
        withIO input =
            flip (++) "\n" $
                init . unlines . reverse . (map unwords) $ 
                    map incSinksToStr $
                        map bottom $
                            toGraphs input

toGraphs :: String -> [Graph]
toGraphs s = 
    let
        cleanInput = init . lines $ s
    in
        toGraphAux cleanInput []
    where
        toGraphAux [] acc = acc
        toGraphAux (n_e:edges:ts) acc =
            let
                (n:_) = map read (words n_e) :: [Int]
            in
                toGraphAux ts $ (addEdges indexFixedEdges $ newGraph n):acc
            where
                es = map read (words edges) :: [Int]
                indexFixedEdges = (map (flip (-) 1) es)

incSinksToStr :: Sinks -> [String]
incSinksToStr = map (\x -> show (x + 1))

newGraph :: Int -> Graph
newGraph = flip replicate []

addEdges :: Edges -> Graph -> Graph
addEdges [] acc = acc
addEdges (x:y:es) acc = addEdges es $ lhs ++ (y:e):rhs
    where
        (lhs,e:rhs) = splitAt x acc

bottom :: [[Int]] -> [Int]
bottom g =
    [y |
        y <- [0..l],
        and [reach [x] y [] g | x <- [0..l]]
    ] where
        l = length g - 1

reach :: [Int] -> Int -> [Int] -> [[Int]] -> Bool
reach [] to visited _ =
    if to `elem` visited then
        True
    else
        False
reach (from:fs) to visited graph =
    if to `elem` visited then
        True
    else
        if from `elem` visited then
            reach fs to visited graph
        else
            reach (fs ++ (graph !! from)) to (from:visited) graph
