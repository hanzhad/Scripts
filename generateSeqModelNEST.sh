#! /bin/bash

ACTION=$1
NAME=$2

declare -a ACTIONS_LIST=(
  scheme
)

program() {
  [[ -z "$ACTION" ]] && {
    echo "Error: not enough arguments";
    return;
  }

    [[ -z "$NAME" ]] && {
    echo "Error: not enough arguments";
    return;
  }

  if [[ $ACTION == "${ACTIONS_LIST[0]}" ]]; then
    MODEL_PATH="./src/$NAME"
    PATH_DTO="$MODEL_PATH/dto"
    DTO_NAME="$MODEL_PATH/dto/$NAME.db.dto.ts"
    SCHEME_NAME="$MODEL_PATH/$NAME.scheme.ts"
    PRITTY_NAME="$(tr '[:lower:]' '[:upper:]' <<< "${NAME:0:1}")${NAME:1}"

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
