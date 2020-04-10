# COVID-19 AWS HPC Cluster

## New User Accounts
<details>
<summary>Click to expand</summary>
<br>

### Prerequisites

* A computer with an internet connection running Microsoft Windows, Mac OS X, or Linux.
* An internet browser such as Chrome, Firefox, or Safari.
* Familiarity with common Linux commands.

### Sign in to the AWS Console
Access the [AWS Management Console](https://signin.aws.amazon.com/console). To sign in, enter your AWS Account ID or alias, IAM user name, and password that was provided to you.

![AWS Console Sign-In](https://user-images.githubusercontent.com/187202/79024818-b358ed00-7b49-11ea-9513-f339cca7a46a.png)


After you sign in, take a few minutes to explore the navigation components of the AWS Management Console.

* A search bar allows you to quickly locate services based on text.
* Recently visited services are located below the search bar.
* In the toolbar, the Services drop-down menu populates a list of all services.
* The Support drop-down menu includes links to support and [documentation](https://docs.aws.amazon.com/).
* The Region drop-down menu allows you to select a specific AWS Region.

![aws-console](https://user-images.githubusercontent.com/187202/79024890-e4d1b880-7b49-11ea-86f1-22e0bdd96ee1.png)

You are now ready to launch the Quick Start 
</br>
</details>

---

## Launch the COVID19 HPC QuickStart Environment

### Step 1
To deploy, click:

| Region       | Stack                                                                                                                                                                                                                                                                                                              |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| us-east-1    | [![amplifybutton](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=AWS-HPC-Quickstart&templateURL=https://covid19hpc-quickstart.s3.amazonaws.com/cfn.yaml)       |
| us-west-2    | [![amplifybutton](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?stackName=AWS-HPC-Quickstart&templateURL=https://covid19hpc-quickstart.s3.amazonaws.com/cfn.yaml)       |
| eu-west-1    | [![amplifybutton](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://eu-west-1.console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?stackName=AWS-HPC-Quickstart&templateURL=https://covid19hpc-quickstart.s3.amazonaws.com/cfn.yaml)       |
| eu-central-1 | [![amplifybutton](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://eu-central-1.console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/create/review?stackName=AWS-HPC-Quickstart&templateURL=https://covid19hpc-quickstart.s3.amazonaws.com/cfn.yaml) |

If you have not authenticated with the [AWS Management Console](https://signin.aws.amazon.com/console), you will be prompted to login with the AWS Account ID or alias, IAM user name, and password that was provided to you. 

### Step 2
After clicking `Launch Stack` you will be redirected to the CloudFormation **Quick create stack** screen. 

<img width="982" alt="Quick create stack" src="https://user-images.githubusercontent.com/187202/79027970-db4d4e00-7b53-11ea-89c1-7feba2029df9.png">

### Step 3

Scroll to the bottom of the page, and leave most of the Parameters as they are. 

1. Fill out the `UserPasswordParameter` with a temporary password. Keep it simple! You will be prompted to change it on first use.

2. Select `I acknowledge that AWS Cloudformation might create IAM resources with custom names`. 

Now, click `Create Stack` to deploy the QuickStart Environment. 

<img width="982" alt="Screen Shot 2020-04-11 at 3 46 48 PM" src="https://user-images.githubusercontent.com/187202/79056281-2df13d80-7c1a-11ea-8fd9-0376832ca791.png">


### Deployment 
Deployment takes about 15 minutes. This QuickStart provisions: 
- a Cloud9 Integrated Development Environment (IDE) in your selected region;
- an AWS Parallel Cluster environment, named `covid-cluster`, for batch scheduled jobs and interactive computing;
- a non-root IAM User, named `hpc-quickstart`, with full access to the AWS Console to create custom architectures. 

Provisioning is complete when all Stacks show *CREATE_COMPLETE*. 

![image](https://user-images.githubusercontent.com/187202/79025531-ab01b180-7b4b-11ea-8234-9bc393f69893.png)
</details>
--- 

## Access Your Cluster

### Step 4
When all stacks show *CREATE_COMPLETE*, click on the `Outputs` tab of the `AWS-HPC-Quickstart` stack. You should see two URLs: one for a Cloud9 environment and a second for user Login. Click on the `UserLoginUrl` and your web browser will be re-directed to an AWS Cloud9 interactive console:

![image](https://user-images.githubusercontent.com/5545980/79009644-d4ebb180-7b14-11ea-9029-e79d75647708.png)

The Cloud9 environment will look like this: 

![Cloud9](https://user-images.githubusercontent.com/187202/79025821-81955580-7b4c-11ea-9f2f-3fd128afe939.png)

### Step 5 
Confirm the name of your AWS Parallel Cluster: 
```
pcluster list
```
The name should be `covid-cluster` and the state should be `CREATE_COMPLETE`. 

Connect to the cluster with the following: 
```
pcluster ssh covid-cluster
```




### Step 6
Now you can log in as a `hpc-quickstart` user, go to the stack "Outputs":

Click on the "UserLoginUrl" and you'll be redirected to a page that looks like:

![image](https://user-images.githubusercontent.com/5545980/79014795-7c221600-7b20-11ea-8933-bdfdd0c7146d.png)

```bash
IAM User Name: hpc-quickstart
Password: [set during stack creation]
```

Fill in the username and password you noted above and you'll be asked to reset the password:

![image](https://user-images.githubusercontent.com/5545980/79014415-b0e19d80-7b1f-11ea-885a-0014109879f2.png)

## FAQ

If you see the following:
**The security token included in the request is invalid**

It's likely an issue with the account having been just created. Wait for some time and try again. 
</details>

## Developer Setup

<details>
<summary>Click to expand</summary>
<br>
The first step is installing node.js, this can be done easily with Homebrew. After that completes, install aws-cdk:

```
$ brew install node
$ npm install -g aws-cdk
```

Now you can activate the python virtualenv and install the python dependencies:

```
$ source .env/bin/activate
$ pip install -r requirements.txt
```

At this point, it's time to setup CDK, the following needs to be done once in each account:

```
$ cdk bootstrap
```

And finally, deploy the app:

```
$ cdk deploy
```

I've surely missed a bunch of python dependencies, the format for installing those is:

```
$ pip install aws-cdk.custom-resources
```

Once it finishes deploy, you'll get an ouput with a link to the Cloud9 URL. Click on that to quickly see the Cloud9 result:

![image](https://user-images.githubusercontent.com/5545980/78568726-61c20280-77d7-11ea-84a5-bdf0d7a0cb95.png)

## Pro-Tips

Use `cdk synth | less` to see the generated template.

Provide parameters to the stack via `cdk deploy --parameters pcluster:KEY=VALUE`.

## Useful commands

 * `cdk ls`          list all stacks in the app
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack with current state
 * `cdk docs`        open CDK documentation

Enjoy!
</details>
