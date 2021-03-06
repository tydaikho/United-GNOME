#! /bin/bash
DISTROS="distros.txt"
COMPILED_FOLDER="sass/compiled-css"
OUTPUT="Compiled"

# GTK2 #
DISTRO_FOLDER="src/gtk-2.0/distro-gtk-files"
ASSETS_FOLDER="src/gtk-2.0/distro-assets"
COMMON_ASSETS_FOLDER="src/gtk-2.0/common-assets"
COMMON_FOLDER="src/gtk-2.0/common-files"
###

echo "Compiling and copying..."
for distro in `cat $DISTROS`; do
  for variant in '','' '-light','-Light' '-opaque','-Dark'; do IFS=","; set -- $variant;
    sassc -t expanded src/gnome-shell/sass/$distro/gnome-shell-$distro${1}.scss $OUTPUT/United-${distro^}/United-${distro^}${2}/gnome-shell/gnome-shell.css
    sassc -t expanded src/gtk-3.0/sass/$distro/gtk-$distro.scss $OUTPUT/United-${distro^}/United-${distro^}/gtk-3.0/gtk.css
    sassc -t expanded src/gtk-3.0/sass/$distro/gtk-$distro-dark.scss $OUTPUT/United-${distro^}/United-${distro^}/gtk-3.0/gtk-dark.css
    rm $OUTPUT/United-${distro^}/United-${distro^}/gtk-3.0/assets/* -R
    cp src/gtk-3.0/common-assets/* $OUTPUT/United-${distro^}/United-${distro^}/gtk-3.0/assets/ -R
    cp src/gtk-3.0/distro-assets/${distro}-assets/* $OUTPUT/United-${distro^}/United-${distro^}/gtk-3.0/assets/ -R
  done

  for variant in "" '-Dark'; do
    rm $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/* -R
    cp src/gnome-shell/common-assets/* $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/ -R
    cp src/gnome-shell/distro-assets/$distro-assets/* $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/ -R
  done

  for variant in '-Dark'; do
    sassc -t expanded src/gtk-3.0/sass/$distro/gtk-$distro-dark.scss $OUTPUT/United-${distro^}/United-${distro^}-Dark/gtk-3.0/gtk.css
    rm $OUTPUT/United-${distro^}/United-${distro^}-Dark/gtk-3.0/assets/* -R
    cp src/gtk-3.0/common-assets/* $OUTPUT/United-${distro^}/United-${distro^}-Dark/gtk-3.0/assets/ -R
    for buttons in '-minimize' '-maximize' '-close'; do
      cp src/gtk-3.0/common-assets/titlebutton${buttons}-dark.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
      cp src/gtk-3.0/common-assets/titlebutton${buttons}-backdrop-dark.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
      cp src/gtk-3.0/distro-assets/${distro}-assets/titlebutton${buttons}-hover*.png $OUTPUT/United-${distro^}/United-${distro^}-Dark/gtk-3.0/assets/
      cp src/gtk-3.0/distro-assets/${distro}-assets/titlebutton${buttons}-active*.png $OUTPUT/United-${distro^}/United-${distro^}-Dark/gtk-3.0/assets/
    done
  done

  for variant in '-Darker'; do
    sassc -t expanded src/gtk-3.0/sass/$distro/gtk-$distro-darker.scss $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/gtk.css
    sassc -t expanded src/gtk-3.0/sass/$distro/gtk-$distro-dark.scss $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/gtk-dark.css
    rm $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/* -R
    cp src/gtk-3.0/common-assets/* $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/ -R
    cp src/gtk-3.0/distro-assets/$distro-assets/* $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/ -R
    for buttons in '-minimize' '-maximize' '-close'; do
      cp src/gtk-3.0/common-assets/titlebutton${buttons}-dark.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
      cp src/gtk-3.0/common-assets/titlebutton${buttons}-backdrop-dark.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
      cp src/gtk-3.0/distro-assets/${distro}-assets/titlebutton${buttons}-hover*.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
      cp src/gtk-3.0/distro-assets/${distro}-assets/titlebutton${buttons}-active*.png $OUTPUT/United-${distro^}/United-${distro^}-Darker/gtk-3.0/assets/
    done
  done

  for variant in '-Light'; do
    cp src/gnome-shell/common-assets/* $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/ -R
    cp src/gnome-shell/common-assets-light/* $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/ -R
    cp src/gnome-shell/distro-assets/$distro-assets/* $OUTPUT/United-${distro^}/United-${distro^}${variant^}/gnome-shell/assets/ -R
  done

  for variant in 'dark'; do
    for file_name in 'Dark'; do
      cp ${DISTRO_FOLDER}/${distro}/gtkrc-${variant}-${distro} Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/gtkrc
      cp ${COMMON_FOLDER}/main.rc Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/main.rc
      cp ${COMMON_ASSETS_FOLDER}-${variant}/* Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/assets/
      cp ${ASSETS_FOLDER}/${distro}/${distro}-${variant}-assets/* Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/assets/
    done
  done
  for variant in 'darker'; do
    for file_name in 'Darker'; do
      cp ${DISTRO_FOLDER}/${distro}/gtkrc-${variant}-${distro} Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/gtkrc
      cp ${COMMON_FOLDER}/main.rc Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/main.rc
      cp src/gtk-2.0/common-assets-light/* Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/assets/
      cp ${ASSETS_FOLDER}/${distro}/${distro}-light-assets/* Compiled/United-${distro^}/United-${distro^}-$file_name/gtk-2.0/assets/
    done
  done
  for variant in 'light'; do
    cp ${DISTRO_FOLDER}/${distro}/gtkrc-${distro} Compiled/United-${distro^}/United-${distro^}/gtk-2.0/gtkrc
    cp ${COMMON_FOLDER}/main.rc Compiled/United-${distro^}/United-${distro^}/gtk-2.0/main.rc
    cp ${COMMON_ASSETS_FOLDER}-${variant}/* Compiled/United-${distro^}/United-${distro^}/gtk-2.0/assets/
    cp ${ASSETS_FOLDER}/${distro}/${distro}-${variant}-assets/* Compiled/United-${distro^}/United-${distro^}/gtk-2.0/assets/
  done
done
