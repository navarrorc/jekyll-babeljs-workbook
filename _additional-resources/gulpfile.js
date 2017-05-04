var gulp = require("gulp"),
    watch = require("gulp-watch"),
    child = require("child_process"),
    gutil = require("gulp-util"),
    webpackStream = require("webpack-stream"),
    webpack2 = require("webpack"),
    browserSync = require("browser-sync").create();

gulp.task("jekyll", function() {
    // see: https://aaronlasseigne.com/2016/02/03/using-gulp-with-jekyll/
    var exec = process.platform === "win32" ? "jekyll.bat" : "jekyll"; // see: http://bit.ly/2pzQeHk
    var jekyll = child.spawn(exec, ["build", "--watch"]); 
    var jekyllLogger = function(buffer) {
        buffer.toString()
            .split(/\n/)
            .forEach(function(message){
                if(message) {
                    gutil.log("Jekyll: " + message);
                }
            });
    };
    
    jekyll.stdout.on("data", jekyllLogger);
    jekyll.stderr.on("data", jekyllLogger);
});

gulp.task("serve", function(){
    var options = {
        server: {baseDir: "_site/"},
        port: process.env.PORT || 8080,
        ui: { port: 8081 }
    };
    browserSync.init(options);    
    watch("_site/**/*", browserSync.reload); // see: http://bit.ly/2qJeZ3d
});

gulp.task("webpack-babeljs", function() {
    return gulp.src("src/entry.js")
        .pipe(webpackStream(require("./webpack.config.js")), webpack2)
        .on("error", function handleError() {
            this.emit("end"); // Recover from errors
        })
        .pipe(gulp.dest("dist/"));
});

gulp.task("default", ["webpack-babeljs","jekyll","serve"]);