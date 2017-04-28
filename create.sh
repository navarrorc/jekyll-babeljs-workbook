#!/bin/bash

read -p "website name? " site

jekyll new $site --blank
#jekyll new $site

cp -a ./_additional-resources/. ./$site/

cd ./$site
mkdir _includes
mkdir _sass

mkdir _site #fixes a timing issue with browserSync in gulpfile.js
touch _site/fix.html
echo "aabbcc" >> _site/fix.html

mkdir css images scripts src dist

cat >> _config.yml <<DELIM

# Custom Excludes
exclude: [gulpfile.js, package.json, node_modules, src]
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
</head>
<body>
    <h1>Hello from Jekyll</h1>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quasi, officiis, illum. Architecto, corporis, dolorem vero iure magnam totam numquam ab molestiae voluptatibus natus aperiam quas odio recusandae reprehenderit accusamus! Possimus, inventore officiis itaque doloribus quas praesentium dolorem animi maiores! Perferendis, iusto, aspernatur, unde ut nihil debitis doloribus ex odit commodi hic provident corporis temporibus ipsum. Nemo, perferendis ullam accusamus voluptatem facere rem repudiandae reiciendis odit vel voluptas sunt nobis natus? Recusandae, unde, mollitia provident consequatur sapiente asperiores hic et iure numquam officiis id quam nobis ullam. Temporibus, commodi, quos, dicta reiciendis atque similique explicabo assumenda enim quidem qui animi perferendis.</p>
    <script src="/dist/bundle.js"></script>
</body>
</html>
DELIM

cat > css/main.scss <<DELIM
---
---

/* CSS Styles are defined below */
body {
    background: Peru;
}
DELIM

cat > src/entry.js <<DELIM
import moment from "moment";
import $ from "jquery"; // Cheat Sheet: bit.ly/2dq090t

var rightNow = moment().format("MMMM Do YYYY, h:mm:ss a");

console.log(rightNow);
// "October 23rd 2016, 9:30:24 pm"
DELIM

npm install