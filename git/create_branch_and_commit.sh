# =======================================================================================
# Create branch, commit changes and push to remote for all repos in the current directory
# =======================================================================================

# Constants
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

read -p "${blue}Enter branch name: ${reset}" branch_name
read -p "${blue}Enter commit message: ${reset}" commit_message

# Check if branch name and commit message are provided
if [ -z "$branch_name" ] || [ -z "$commit_message" ]; then
    echo -e "${red}Please provide branch name and commit message.${reset}"
    read -p "Press enter to exit"
    exit 1
fi

# Script
cd $(dirname $0)

for repo in */; do
    echo -e "${green}Checking $repo${reset}"
    cd $repo

    current_branch=$(git symbolic-ref --short HEAD)
    echo -e "${blue}Current branch: $current_branch.${reset}"

    # Check for changes
    if [[ `git status --porcelain --untracked-files=no` ]]; then
        git checkout -b "$branch_name"
        git add .
        git commit -m "$commit_message"
        git push origin "$branch_name"
        git checkout $current_branch
    else
        echo -e "${blue}No changes detected. Skipping...${reset}"
    fi
    cd ..
done
read -p "${blue}Press enter to exit${reset}"