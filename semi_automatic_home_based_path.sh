home_dir=$(echo $HOME) &&
read website_path_after_home_dir && 
full_path=$home_dir+=$website_path_after_home_dir # Note the +=
