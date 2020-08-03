const gulp = require('gulp'),
      connect = require('gulp-connect'),
      { spawn } = require('child_process'),
      pump = require('pump');

gulp.task('build.html', function(cb) {
    const builder = spawn('sphinx-build', ['-b', 'html', 'source', 'build/html'], {
        stdio: 'inherit'
    });
    builder.on('exit', cb);
});

gulp.task('build', gulp.series('build.html'));

gulp.task('default', gulp.series('build'));

gulp.task('watch', gulp.series('default', function(cb) {
    gulp.watch([
        'source/**/*',
    ], gulp.series('build'));
    cb();
}));

gulp.task('serve', gulp.parallel('watch', function(cb) {
    connect.server({
        root: 'build/html',
        port: '8080',
    });
    cb();
}));
