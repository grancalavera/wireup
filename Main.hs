import System.Directory (
    canonicalizePath
  , setCurrentDirectory
  , getCurrentDirectory
  )
import System.Environment (getArgs)
import System.IO (FilePath)

main :: IO ()
main = do
  args <- getArgs
  case args of
    []     -> putStrLn "usage"
    [path] -> resolveTargetDir path
    _      -> putStrLn "too many args"

resolveTargetDir :: FilePath -> IO ()
resolveTargetDir path = do
  restore   <- getCurrentDirectory
  canonical <- canonicalizePath path
  setCurrentDirectory canonical
  target <- getCurrentDirectory
  setCurrentDirectory restore
  current <- getCurrentDirectory
  putStrLn $ "current: " ++ current
  putStrLn $ "target:  " ++ target
  putStrLn $ "program: " ++ programName target

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split f (x:xs)
  | f x       = [] ++ split f xs
  | otherwise = [current] ++ split f next
  where
    (current, next) = span (not . f) (x:xs)
    -- same as
    -- xs' = (x:xs)
    -- current = takeWhile (not . f) xs'
    -- next    = dropWhile (not . f) xs'

programName :: FilePath -> FilePath
programName path = last $ split (=='/') path
