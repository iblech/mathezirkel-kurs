# How to include animated GIFs in LaTeX

Over at the TeX StackExchange, there are diverse recommendations on how to
include animated GIFs in PDF files produced by LaTeX. Some of these employ
now-obsolete packages like `media15` or require the Adobe Acrobat Reader and
didn't work for me. In particular, solutions proposing the `animate` package
didn't work. The solution described here works on a modern (2017) system.


## In three steps

1. Convert the GIF to an MP4 video. On your system, the `convert` tool from
   the excellent ImageMagick suite might do the trick (`convert foo.gif
   foo.mp4`), but it didn't work for me. In any case, you can use `avconv`
   (formerly known as `ffmpeg`, included in the Debian package `libav-tools`
   and in the Nix package `libav`):

   ```
   convert foo.gif frames-%03d.png
   avconv -i frames-%03d.png -vcodec copy -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" foo.mp4
   ```

2. Include the `multimedia` package in the LaTeX preamble
   (`\usepackage{multimedia}`) and then include the video using something like
   `\movie[width=5cm,height=5cm,autostart,loop,poster,showcontrols]{}{foo.mp4}`.
   Use `pdflatex` to run LaTeX.

4. Use Okular as PDF viewer. Neither MuPDF nor Evince nor Mozilla's PDF.js
   worked for me. You can test whether your favorite PDF viewer supports the
   technique described here by [having a look at this PDF
   file](https://rawgit.com/iblech/mathezirkel-kurs/master/vierdimensionale-geometrie/slides-weihnachtsvorlesung.pdf).


## Caveats

* So-called "optimized GIF" files can lead to badly-looking artifacts.
  Use `gifsicle --unoptimize` before passing those to `convert`. This tool is
  part of the equally-named Debian and Nix packages. You can use [this shell
  script](gif2mp4.sh) to run `gifsicle`, `convert`, and `avconv` in one step.
  The script reads from STDIN and writes to STDOUT, so use it like
  `./gif2mp4.sh < foo.gif > foo.mp4`.

* If in the `\movie` command you don't specify the height, it will be
  automatically calculated from the width so as to preserve the aspect ratio.
  If on the other you don't specify the width, the movie will be included with
  a width of (what appears to be) zero pixels.

* Okular displays the animations only in presentation mode (Ctrl+Shift+P).

* At the time of writing, Okular didn't properly work on NixOS when made
  available using `nix-shell -p okular`; it worked when installed globally.
  Additionally, the packages `libsForQt5.phonon-backend-vlc` and `xorg.libxcb`
  need to be installed.
