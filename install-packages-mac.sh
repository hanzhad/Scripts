PROJECT_FOLDER_NAME=$1
PATH_TO_WORK_DIR="$(pwd)"

for entry in ${PATH_TO_WORK_DIR}/${PROJECT_FOLDER_NAME}/*; do
echo "Proccessing $entry ..."
cd $entry
git checkout develop
git pull origin develop
npm i --all
npm run submodule-setup
git checkout develop
cd ../..
done
