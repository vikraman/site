{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Data.Char
import Data.Hash.MD5
import Data.List
import Data.Monoid
import Hakyll
import Hakyll.Web.Sass
import System.FilePath.Posix
import Text.Pandoc.Options

main :: IO ()
main = hakyllWith defaultConfiguration {
  deployCommand = "rsync -avchzP _site vikraman@internal.vikraman.org:"
  } $ do

  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "files/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "js/**" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*.scss" $ do
    route $ setExtension "css"
    compile (fmap compressCss `fmap` sassCompiler)

  match "index.markdown" $ do
    route $ setExtension "html"
    compile $ do
      posts <- loadAll allPosts
              >>= fmap (take 0) . recentFirst
      let indexCtx =
            listField "posts" postCtx (return posts) <>
            constField "avatar" gravatar             <>
            constField "email1" email1   <>
            constField "email2" email2   <>
            defaultContext
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= renderPandocWith pandocReaderOptions pandocWriterOptions
        >>= loadAndApplyTemplate "templates/page.html"    defaultContext
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= removeIndexHtml
        >>= relativizeUrls

  match allPosts $ do
    route niceRoute
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    postCtx
      >>= saveSnapshot "content"
      >>= loadAndApplyTemplate "templates/default.html" postCtx
      >>= removeIndexHtml
      >>= relativizeUrls

  create ["archive/index.html"] $ do
    route idRoute
    compile $ do
      posts <- loadAll allPosts >>= recentFirst
      let archiveCtx =
            listField "posts" postCtx (return posts) <>
            constField "title" "Archive"             <>
            defaultContext

      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/page.html"    archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= removeIndexHtml
        >>= relativizeUrls

  create ["atom.xml"] $ do
    route idRoute
    compile $ compileFeeds >>= renderAtom feedCfg feedCtx

  create ["rss.xml"] $ do
    route idRoute
    compile $ compileFeeds >>= renderRss feedCfg feedCtx

  match "templates/*" $ compile templateCompiler

author :: String
author = "Vikraman Choudhury"

email :: String
email = email1

email1 :: String
email1 = user <> "@" <> host
  where name = map toLower $ head $ words author
        user = "me"
        host = name ++ ".org"

email2 :: String
email2 = user <> "@" <> host
  where name = (map toLower $ head $ words author) ++ "." ++ (map toLower $ head . tail $ words author)
        user = name
        host = "glasgow.ac.uk"

gravatar :: String
gravatar = "https://www.gravatar.com/avatar/" <> hash <> ext <> size
  where hash = md5s . Str $ map toLower email
        ext  = ".png"
        size = "?s=192"

allPosts :: Pattern
allPosts = "posts/*/*/*/*.markdown"

postCtx :: Context String
postCtx =
  dateField "date" "%B %e, %Y" <>
  defaultContext

feedCtx :: Context String
feedCtx = postCtx <> bodyField "description"

feedCfg :: FeedConfiguration
feedCfg =
    FeedConfiguration
    { feedTitle       = "Vikraman Choudhury"
    , feedDescription = "Vikraman's homepage"
    , feedAuthorName  = author
    , feedAuthorEmail = email
    , feedRoot        = "https://vikraman.org"
    }

compileFeeds :: Compiler [Item String]
compileFeeds = loadAllSnapshots allPosts "content"
               >>= fmap (take 10) . recentFirst

niceRoute :: Routes
niceRoute = customRoute createIndexRoute
  where
    createIndexRoute ident =
      takeDirectory p </> takeBaseName p </> "index.html"
      where p = toFilePath ident

removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item
  where
    removeIndexStr :: String -> String
    removeIndexStr url = case splitFileName url of
        (dir, "index.html") | isLocal dir -> dir
        _                                 -> url
        where isLocal uri = not ("://" `isInfixOf` uri)

pandocReaderOptions :: ReaderOptions
pandocReaderOptions = def { readerExtensions = phpMarkdownExtraExtensions }

pandocWriterOptions :: WriterOptions
pandocWriterOptions = def
