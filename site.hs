{-# LANGUAGE OverloadedStrings #-}

import Data.Char     (toLower)
import Data.Hash.MD5 (Str (..), md5s)
import Data.List     (intersperse)
import Data.Monoid   (mconcat, (<>))
import Hakyll

main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match (fromList ["about.rst", "contact.markdown"]) $ do
    route   $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match allPosts $ do
    route $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    postCtx
      >>= saveSnapshot "content"
      >>= loadAndApplyTemplate "templates/default.html" postCtx
      >>= relativizeUrls

  create ["archive.html"] $ do
    route idRoute
    compile $ do
      posts <- loadAll allPosts >>= recentFirst
      let archiveCtx =
            listField "posts" postCtx (return posts) <>
            constField "title" "Archives"            <>
            defaultContext

      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= relativizeUrls

  create ["atom.xml"] $ do
    route idRoute
    compile $ compileFeeds >>= renderAtom feedCfg feedCtx

  create ["rss.xml"] $ do
    route idRoute
    compile $ compileFeeds >>= renderRss feedCfg feedCtx

  match "index.html" $ do
    route idRoute
    compile $ do
      posts <- loadAll allPosts
               >>= fmap (take 10) . recentFirst
      let indexCtx =
            listField "posts" postCtx (return $ take 5 posts) <>
            constField "title" "Home"                         <>
            constField "avatar" gravatar                      <>
            defaultContext

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateCompiler

author :: String
author = "Vikraman Choudhury"

email :: String
email = user <> "@" <> host
  where user = mconcat $ intersperse "." $ map (map toLower) $ words author
        host = reverse "moc.liamg"

gravatar :: String
gravatar = "https://www.gravatar.com/avatar/" <> hash <> ext <> size
  where hash = md5s . Str $ map toLower email
        ext  = ".png"
        size = "?s=200"

allPosts :: Pattern
allPosts = "posts/*/*/*/*.markdown"

postCtx :: Context String
postCtx =
  dateField "date" "%B %e, %Y" <>
  defaultContext

feedCtx :: Context String
feedCtx = postCtx <> bodyField "description"

feedCfg :: FeedConfiguration
feedCfg = FeedConfiguration { feedTitle = "Vikraman's blog"
                            , feedDescription = "Blog posts by Vikraman"
                            , feedAuthorName = author
                            , feedAuthorEmail = email
                            , feedRoot = "http://vikraman.org"
                            }

compileFeeds :: Compiler [Item String]
compileFeeds = loadAllSnapshots allPosts "content"
               >>= fmap (take 10) . recentFirst
