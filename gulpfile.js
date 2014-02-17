var gulp    = require('gulp'),
    gutil   = require('gulp-util'),
    uglify  = require('gulp-uglify'),
    concat  = require('gulp-concat'),
    coffee  = require('gulp-coffee');

var paths = {
  scripts: ['public/js/*.coffee']
};

gulp.task('scripts', function() {
  gulp.src(paths.scripts)
      .pipe(coffee({ bare: true }).on('error', gutil.log))
      .pipe(uglify())
      .pipe(concat('main.js'))
      .pipe(gulp.dest('./public/js'));
});

gulp.task('watch', function () {
  gulp.watch(paths.scripts, ['scripts']);
});

gulp.task('default', ['scripts', 'watch']);