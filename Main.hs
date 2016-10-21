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
    [path] -> resolveParent path
    _      -> putStrLn "too many args"

resolveParent :: FilePath -> IO()
resolveParent path = do
  restore   <- getCurrentDirectory
  canonical <- canonicalizePath path
  setCurrentDirectory canonical
  current <- getCurrentDirectory
  putStrLn current

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split f (x:xs)
  | f x       = [ current ] ++ split f next
  | otherwise = [ x : current ] ++ split f next
  where
    (current, next) = span (not . f) xs

directoryName :: FilePath -> FilePath
directoryName path = last $ split (=='/') path
