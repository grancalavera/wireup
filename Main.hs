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
    
resolveParent path = 
  canonicalizePath path >>= 
  setCurrentDirectory   >>
  getCurrentDirectory   >>=
  putStrLn

--do
--  canonical <- canonicalizePath path
--  setCurrentDirectory canonical
--  current <- getCurrentDirectory
--  putStrLn current  

