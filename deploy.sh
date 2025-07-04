theme_name=$(awk '/^theme_name/{print $3}' deploy.conf)
theme_repo_url=$(awk '/^theme_repo_url/{print $3}' deploy.conf)
theme_repo_branch=$(awk '/^theme_repo_branch/{print $3}' deploy.conf)
theme_clone_cache=theme
theme_path=$theme_clone_cache/"$theme_name"_deploy

echo 'Pulling theme repository...'
git clone -b $theme_repo_branch $theme_repo_url $theme_clone_cache
echo 'Pulling done.'

echo "Theme selected: $theme_name ($theme_path)"
if [ -d $theme_path ]; then
  echo 'Merging Start...'
  rm -rf $theme_path/.git
  cp -rnf $theme_path/* .
  rm -rf $theme_path
  rm -rf $theme_clone_cache
  echo 'Merging End.'
else
  echo 'Theme not found.'
fi
