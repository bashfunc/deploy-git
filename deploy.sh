# Check if git branch is master
echo "------------------------------"
echo "Local: Checking for master branch..."
echo "------------------------------"
currentBranch=$(git rev-parse --abbrev-ref HEAD)
host="username@ssh.host.com"
masterBranch="master"
if [ $currentBranch == $masterBranch ]
then
    # build for production
    echo "Local: Building for production..."
    ng build --prod

    # add production files
    echo "Local: Adding production files to local git repository..."
    git add .

    # commit production files
    echo "Local: Committing production files..."
    currentDate=$(date)
    git commit -m "Deployed website on: $currentDate"

    # push production files to remote repository
    echo "Local: Pushing production files to remote repository..."
    git push

    # update website contents
    echo "Local: Updating website contents..."
    
    ssh -t $host "./update-website.sh"
else
    # wrong branch message
    echo "Local: You can only deploy from the master branch..."
fi
echo "------------------------------"
