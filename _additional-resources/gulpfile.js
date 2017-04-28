var gulp = require('gulp');
var webpackStream = require('webpack-stream');
var webpack2 = require('webpack');
var shell = require('gulp-shell');
var browserSync = require('browser-sync').create();

gulp.task('build', shell.task(['jekyll build --watch']));

gulp.task('serve', function(){
    var options = {
        server: {baseDir: '_site/'},
        port: process.env.PORT,
        ui: { port: 8081 }
    };
    browserSync.init(options);
    gulp.watch('_site/**/*.*').on('change', browserSync.reload);
});

gulp.task('webpack-babeljs', function() {
    return gulp.src('src/entry.js')
        .pipe(webpackStream(require('./webpack.config.js')), webpack2)
        .on('error', function handleError() {
            this.emit('end'); // Recover from errors
        })
        .pipe(gulp.dest('dist/'));
});

//gulp.task('default', ['serve', 'build']);
gulp.task('default', ['webpack-babeljs','serve','build']);