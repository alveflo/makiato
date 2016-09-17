var gulp = require("gulp");
var coffee = require("gulp-coffee");
var gutil = require("gutil");

gulp.task("default", () => {
  gulp.src("./src/**/*.coffee")
    .pipe(coffee({ "bare": true }).on("error", gutil.log))
    .pipe(gulp.dest("./lib"));
});
