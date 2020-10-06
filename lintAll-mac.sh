PATH_TO_WORK_DIR="$(pwd)"
JSON="./package.json"

run() {
  FOLDER=$1
  shift
  if [[ ! -d $FOLDER ]]; then
    echo "ERROR $FOLDER IS NOT A FOLDER!"
    return 1
  fi

  cd "$FOLDER" || return

  if [[ ! -f "$JSON" ]]; then
    echo "ERROR $FOLDER DOEST NOT HAVE $JSON!"
    return 1
  fi

  echo "Proccessing $FOLDER ..."
    if [ "$IS_FIX_REQ" = true ]; then
      echo "Fixing ..."
      yarn lint --fix
  fi


  echo "Show result ..."
  yarn lint
}

IS_FIX_REQ=false

while getopts "f" option; do
  case "${option}" in

  f)
    IS_FIX_REQ=true
    ;;
  *) ;;
  esac
done

for FOLDER in "$PATH_TO_WORK_DIR"/*; do
  run "$FOLDER"
done
