gulp = require 'gulp'
coffee = require('gulp-coffee')
gutil = require('gulp-util')
browserify = require('browserify')
glob = require('glob')
streamConvert = require('vinyl-source-stream')

gulp.task 'coffee', () ->
  gulp.src('./src/*.coffee')
  .pipe(coffee({ bare: true }).on('error', gutil.log))
  .pipe(gulp.dest('./lib/'))

gulp.task 'prepareTests', ['build'], () ->
  bundler = browserify({entries: glob.sync("./test/*Tests.coffee"), extensions: [".coffee"] })
  stream = bundler.bundle()
    .pipe(streamConvert('browserified.js'))
    .pipe(gulp.dest('./test'))
  return stream

gulp.task 'build', ['coffee']
gulp.task 'default', ['build']
