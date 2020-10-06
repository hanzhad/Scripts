#! /bin/bash

ACTION=$1
NAME=$2

declare -a ACTIONS_LIST=(
  schema
)

split() {
  STRING="$1"
  IFS="$2"
  local RESULT;

  [[ -z "$STRING" ]] && {
    echo "Error: not enough arguments 1";
    return;
  }

  [[ -z "$IFS" ]] && {
    echo "Error: not enough arguments 2";
    return;
  }

  [[ -z "$3" ]] && {
    echo "Error: not enough arguments 3";
    return;
  }

  n=0

  for (( i=0; i<${#STRING}; i++ )); do
    CHAR="${STRING:$i:1}"
    if [[ "$CHAR" == "$IFS" ]]; then
      unset TEMP
      n=$((n + 1))
    else
      TEMP="$TEMP$CHAR"
      RESULT[$n]=$TEMP
    fi
  done
  eval "$3"=\('"${RESULT[@]}"'\);
  return
}

toClassName(){
  local RESULT_STRING
  S=()
  split "$1" - S

  for (( i=0; i<${#S}; i++ )); do
   temp="$(tr '[:lower:]' '[:upper:]' <<< "${S[$i]:0:1}")${S[$i]:1}"
   RESULT_STRING="$RESULT_STRING$temp"
   unset temp
  done

  eval "$2"=\('"$RESULT_STRING"'\)
}

program() {
  [[ -z "$ACTION" ]] && {
    echo "Error: not enough arguments";
    return;
  }

    [[ -z "$NAME" ]] && {
    echo "Error: not enough arguments";
    return;
  }
   local PRITTY_NAME
   toClassName "$NAME" PRITTY_NAME
   echo $PRITTY_NAME

  if [[ $ACTION == "${ACTIONS_LIST[0]}" ]]; then
    MODEL_PATH="./src/$NAME"
    PATH_DTO="$MODEL_PATH/dto"
    DTO_NAME="$MODEL_PATH/dto/$NAME.db.dto.ts"
    SCHEME_NAME="$MODEL_PATH/$NAME.schema.ts"

    SCHEME="import { Column, Model, Table } from 'sequelize-typescript';
import { ${PRITTY_NAME}DbDto } from \"./dto/${NAME}.db.dto\";

@Table
export class ${PRITTY_NAME}Scheme extends Model<${PRITTY_NAME}DbDto> implements ${PRITTY_NAME}DbDto {

}
"

    DTO="export interface ${PRITTY_NAME}DbDto {

}
"
    mkdir -p "$PATH_DTO"
    touch "$DTO_NAME"
    touch "$SCHEME_NAME"

    echo "$SCHEME" >> "$SCHEME_NAME"
    echo "$DTO" >> "$DTO_NAME"

    return;
  fi

}

program

