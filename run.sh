#!/bin/bash

function install_json() {
  echo -e "\ngem 'json'" >> Gemfile
  echo -e "\nAdded json dependency to Gemfile."
}

function install_widgets() {
  WIDGETS=$@
  if [[ ! -z "$WIDGETS" ]]; then
    for WIDGET in $WIDGETS; do
      echo -e "\nInstalling widget from gist $WIDGET"
      smashing install "$WIDGET"
    done
  fi
}

function install_gems() {
  GEMS=$@
  IFS="|" read -a gems_array <<< "$GEMS"

  echo -e "\nInstalling gem(s): $GEMS"
  for GEM in "${gems_array[@]}"
  do
      echo -e "\ngem $GEM"
      echo -e "\ngem $GEM" >> Gemfile
  done
  bundle install
}

if [[ ! -e /installed ]]; then
  install_json
  install_widgets $WIDGETS
  install_gems $GEMS
  touch /installed
fi

if [[ ! -z "$PORT" ]]; then
  PORT_ARG="-p $PORT"
fi

# Start smashing
exec smashing start $PORT_ARG

