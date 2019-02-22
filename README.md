# sam-automation with CloudFormation

Pre-conditions

- bash (tested with Terminal.app)
- AWS CLI installed configured (IAM user with admin permissions)
- Setup Steps for SSH Connections to AWS CodeCommit Repositories: https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ssh-unixes.html?icmpid=docs_acc_console_connect_np

Create new CodeCommit git repository

    ./create-stack-gitrepo.sh hellsam

Create a SAM hello world application and push to your newly created git repository

    export REPO_SSH_URL=$(./describe-stack-gitrepo-url.sh hellsam)
    
    git clone https://github.com/chtzuehlke/sam-codebuild-hello-world.git
    cd sam-codebuild-hello-world/
    rm -fR .git

    git init
    git add .
    git commit -m "First commit"
    git status
    git remote add origin $REPO_SSH_URL
    git remove -v
    git remote -v
    git push -u origin master

Create CI/CD pipeline

    ./create-stack-sam-ci-cd.sh hellsam

Test your deployed SAM function

    API_URL=$(./describe-stack-sam-url.sh hellsam)
    curl $API_URL

Modify and test your re-deployed function

    echo '{ "Parameters" : { "SAMDemoParam" : "New env value" } }' > packaged.dev.json
    git commit -a -m "param adjusted"
    git push

    sleep 180

    curl $API_URL

Done :)
