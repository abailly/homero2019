{-# LANGUAGE LambdaCase #-}
import           Control.Applicative
import           Control.Monad       (void, when)
import           Data.Char
import qualified Data.List           as List
import           Data.Monoid
import           System.Directory
import           System.Environment
import           System.IO
import           Web.Tweet

-- | Break the text in standard input into tweet-sized chunks
--
-- The size of a tweet is at most 280 characters. This reads a local file,
-- if it exists, called `.break` which should contain the index of the last split
-- so that we can repeatedly call this program to generate tweets. The `.break` file
-- is updated accordingly
main :: IO ()
main = do
  (numTweets, doTweet) <- getOptions
  getContents >>= makeTweets doTweet numTweets

makeTweets :: Bool -> Int -> String -> IO ()
makeTweets _ 0 _ = pure ()
makeTweets doTweet numTweets content = do
  start <- readBreak <|> pure 0
  let ws = List.inits . drop start . words . filter (not . isDigit) $ content
      sentence = lastWithPunctuation $ takeWhile ((< 260) . length . unwords) ws
      end = start + length sentence
      tweet = unwords sentence <> " #homero2019"
  putStrLn tweet
  when doTweet $ void $ basicTweet tweet ".cred.toml"
  writeBreak end
  makeTweets doTweet (numTweets - 1) content

getOptions :: IO (Int, Bool)
getOptions = getArgs >>= \case
  [] -> pure (1, False)
  [n, "y" ] -> pure (read n, True)
  [n, "Y" ] -> pure (read n, True)
  [n, "yes" ] -> pure (read n, True)
  (n:_) -> pure (read n, False)

lastWithPunctuation :: [[ String ]] -> [String]
lastWithPunctuation ws = head $ dropWhile (\ s -> not $ isPunctuation $ head $ head $ reverse <$> reverse s) sw
  where
    sw = reverse ws

writeBreak :: Int -> IO ()
writeBreak = writeFile ".break" . show

readBreak :: IO Int
readBreak = do
  exist <- doesFileExist ".break"
  if exist
    then read <$> readFile ".break"
    else pure 0
