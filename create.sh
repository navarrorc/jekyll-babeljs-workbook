#!/bin/bash

read -p "website name? " site

jekyll new $site --blank

cp -a ./_additional-resources/. ./$site/

cd ./$site
mkdir _includes _sass _site
mkdir css images scripts src dist

cat >> _config.yml <<DELIM

# Custom Excludes
exclude: [gulpfile.js, package.json, node_modules, src, webpack.config.js]
DELIM

cat > index.html <<DELIM
---
title: $site
---
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>{{ page.title }}</title>
    <link rel="icon" href="{{ site.github.url }}/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="{{ site.github.url }}/css/main.css" type="text/css" />
</head>

<body>
    <h1>Let's learn HTML, CSS and JavaScript using Jekyll</h1>
    <h3>What is Jekyll?</h3> <span><< Click the question</span>
    <div id="description">
        <img class="logo" src="{{ site.github.url }}/images/logo-2x.png">
        <p>A static site generator that converts templates and raw text files into a plain HTML website that's ready to be publish on any web server. </p>
    </div>
    <div class="buttons">
        <button id="button1">A random Integer</button>
        <button id="button2">A random Integer in a Range</button>
    </div>
    <div id="output"></div>
    <script src="{{ site.github.url }}/dist/bundle.js"></script>
</body>

</html>
DELIM

cat > css/main.css <<DELIM
/* CSS Styles are defined below */
body {
    font-family: Sans-serif;
    background: #333333;
}

h3 {
    display: inline-block;
    cursor: pointer;
    margin: 0;
}
h3:hover {
    color: #FFCC00!important;
}

h3 ~ span {
    color: white;
    font-size: 12px;
}

#description {
    display: none;
    text-align: center;
}

.logo {
    width: 400px;
}

.buttons {
    margin-top: 10px;
}
#button1, 
#button2 {
    background-color: #FFCC00;
    border: 2px solid #FFCC00;
    border-radius: 5px;
    height: 30px;
    text-transform: uppercase;
    font-weight: 700;
    cursor: pointer;
}

#output {
    color: #fff;
    padding-top: 10px;
}

/**
 * Media Queries
 **/
@media (max-width: 480px) {
    .logo {
        width: 300px;
    }
    .buttons * {
        font-size: 9px;
    }
}
DELIM

cat > src/app.js <<DELIM
/* global $ */
import moment from "moment";


var rightNow = moment().format("MMMM Do YYYY, h:mm:ss a");
console.log(rightNow);
// i.e. "October 23rd 2016, 9:30:24 pm"

function getRandomNumber(min, max){
    if (min >=0 && max > min){
        return Math.floor(Math.random() * (max - min) + min);
    }
    return Math.floor(Math.random() * 1000000);
}


// jQuery Cheat Sheet: http://bit.ly/2dq090t
$("h1, h3, p").css("color", "#F8F8F8");

var $h3 = $("h3");
$h3.click(function(){
    $("#description").fadeToggle("slow");
});

$("#button1").click(function(){
    var randomNumber = getRandomNumber();
    $("#output").show().text(randomNumber); 
});

$("#button2").click(function(){
    // see: https://mzl.la/1uDCHOb
    var randomNumber = getRandomNumber(0, 20); // whole number between 0 and 19
    $("#output").show().text(randomNumber); 
});
DELIM

npm install