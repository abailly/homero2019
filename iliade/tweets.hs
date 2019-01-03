#!/usr/bin/env stack
-- stack runhaskell --resolver lts-12.5 --

{-# LANGUAGE LambdaCase #-}
import           Control.Applicative
import           Data.Char
import qualified Data.List           as List
import           Data.Monoid
import           System.Directory
import           System.Environment
import           System.IO

-- | Break the text in standard input into tweet-sized chunks
--
-- The size of a tweet is at most 280 characters. This reads a local file,
-- if it exists, called `.break` which should contain the index of the last split
-- so that we can repeatedly call this program to generate tweets. The `.break` file
-- is updated accordingly
main :: IO ()
main = do
  numTweets <- getNumTweets
  getContents >>= makeTweets numTweets

makeTweets :: Int -> String -> IO ()
makeTweets 0 _ = pure ()
makeTweets numTweets content = do
  start <- readBreak <|> pure 0
  let ws = List.inits . drop start . words . filter (not . isDigit) $ content
      sentence = lastWithPunctuation $ takeWhile ((< 260) . length . unwords) ws
      end = start + length sentence
  putStrLn $ unwords sentence <> " #homero2019"
  writeBreak end
  makeTweets (numTweets - 1) content

getNumTweets :: IO Int
getNumTweets = getArgs >>= \case
  [] -> pure 1
  (n:_) -> pure $ read n

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
