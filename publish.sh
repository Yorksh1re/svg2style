set -e

rm -rf ./dist

npm run build

cp README.md package.json LICENSE ./dist

old_registry=$(npm config get registry)
npm config set registry https://registry.npmjs.org
set +e
whoami=$(npm whoami 2>/dev/null)
set -e

if [ -z "$whoami" ]; then
   echo "login plz..."
   npm login
fi
echo "I am: $(npm whoami)"

sleep 1
echo "Begin publish..."
npm publish ./dist/ --access=public "$@"

npm config set registry ${old_registry}
