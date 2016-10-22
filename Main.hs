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
  | f x       = [ current ] ++ next'
  | otherwise = [ x : current ] ++ next'
  where
    (current, next) = span (not . f) xs
    next' = split f next

programName :: FilePath -> FilePath
programName path = last $ split (=='/') path
