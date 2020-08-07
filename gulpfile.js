const gulp = require('gulp'),
      clean = require('gulp-clean'),
      connect = require('gulp-connect'),
      { spawn } = require('child_process'),
      pump = require('pump');

gulp.task('clean', function(cb) {
    pump([
        gulp.src('build', {read: false, allowEmpty: true}),
        clean(),
    ], cb);
});

gulp.task('build.html', function(cb) {
    const builder = spawn('sphinx-build', ['-b', 'html', 'source', 'build/html'], {
        stdio: 'inherit'
    });
    builder.on('exit', cb);
});

gulp.task('build', gulp.series('build.html'));

gulp.task('default', gulp.series('clean', 'build'));

gulp.task('watch', gulp.series('default', function(cb) {
    gulp.watch([
        'source/**/*',
    ], gulp.series('clean', 'build'));
    cb();
}));

gulp.task('serve', gulp.parallel('watch', function(cb) {
    connect.server({
        root: 'build/html',
        port: '8080',
    });
    cb();
}));
