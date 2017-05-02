var gulp = require('gulp');
var child = require('child_process');
var gutil = require('gulp-util');
var webpackStream = require('webpack-stream');
var webpack2 = require('webpack');
var browserSync = require('browser-sync').create();

//gulp.task('build', shell.task(['jekyll build --watch']));

gulp.task('jekyll', function() {
    // see: https://aaronlasseigne.com/2016/02/03/using-gulp-with-jekyll/
    var jekyll = child.spawn('jekyll', ['build', '--watch']);
    var jekyllLogger = function(buffer) {
        buffer.toString()
            .split(/\n/)
            .forEach(function(message){
                if(message) {
                    gutil.log('Jekyll: ' + message);
                }
            });
    };
    
    jekyll.stdout.on('data', jekyllLogger);
    jekyll.stderr.on('data', jekyllLogger);
});

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
// gulp.task('default', ['webpack-babeljs','serve','build']);
gulp.task('default', ['webpack-babeljs','jekyll','serve']);