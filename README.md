# Courses
資訊研究社課程投影片[http://ntnucic.github.io/Courses/](http://ntnucic.github.io/Courses/)

##Slide's Name
使用西元日期命名資料夾，e.g.
```
slides/20121221/
```
並將slide本身命名為index，e.g.
```
slides/20121221/index.html
```
或在減號後加上關鍵字，e.g.
```
slides/20121221-Doom/index.html
```
其餘範例檔案、附件檔案與圖片、影片等多媒體資料也放置於同一資料夾中。

##Deploy
若本地端gh-pages不存在則先建立：
```
git branch gh-pages
```
之後移至gh-pages將最新版本merge後上傳：
```
git checkout gh-pages
git merge master
git push <remote> gh-pages
```

##reveal.js
Use reveal.js 3.1.0.

* [reveal.js](https://github.com/hakimel/reveal.js)

* [reveal.js demo](http://lab.hakim.se/reveal-js/#/)
