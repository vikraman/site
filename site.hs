{-# LANGUAGE OverloadedStrings #-}

import Data.Char     (toLower)
import Data.Hash.MD5 (Str (..), md5s)
import Data.Monoid   ((<>))
import Hakyll

email :: String
email = user <> "@" <> host
  where user = reverse $ "yruhduohc" <> "." <> "namarkiv"
        host = reverse "moc.liamg"

gravatar :: String
gravatar = "https://www.gravatar.com/avatar/" <> hash <> ext <> size
  where hash = md5s . Str $ map toLower email
        ext  = ".png"
        size = "?s=200"

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

    match "posts/*/*/*/*.markdown" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*/*/*/*.markdown"
            let archiveCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Archives"            <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*/*/*/*.markdown"
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

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext
