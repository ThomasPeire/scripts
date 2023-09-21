# ====================================================
# Update master for all repos in the current directory
# ====================================================

# Constants
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

# Script
cd $(dirname $0)

for repo in */; do
    echo -e "${green}Checking $repo${reset}"
    cd $repo

    # Save the name of the current branch
    current_branch=$(git symbolic-ref --short HEAD)
    echo -e "${blue}Current branch: $current_branch.${reset}"

    # Check for changes and untracked files
    if [ -z "$(git status --porcelain)" ]; then
        # No changes
        if [ "$current_branch" != "master" ]; then
            echo -e "${blue}Checking out master...${reset}"
            git checkout master
        fi
        echo -e "${blue}Updating master...${reset}"
        git fetch origin
        git pull origin master
        # Return to the originally checked-out branch
        if [ "$current_branch" != "master" ]; then
            echo -e "${blue}Returning to branch: $current_branch...${reset}"
            git checkout $current_branch
        fi
    else
        # Changes detected
        echo -e "${red}Uncommitted changes detected in $repo. Skipping...${reset}"
    fi
    cd ..
done
read -p "${blue}Press enter to exit${reset}"