# Terraform S3 Backend Setup Project

This project demonstrates how to use Terraform to create an Amazon S3 bucket and configure it as a remote backend for storing Terraform state files. Using a remote backend helps ensure state consistency, facilitates collaboration, and improves infrastructure management workflows.

## Project Overview

In this project:

An S3 bucket is created using Terraform.

This bucket is configured as the Terraform backend to store the terraform.tfstate file.

Optional features (if used) include enabling versioning and server-side encryption.

#### **Project Structure**


├── main.tf----------|| In this we've created S3-Bucket and the Object to store our Stage file.

├── backend.tf------|| In this we have Stored the S3-Backend Configuration

├── outputs.tf-------|| In this the Outputs are stored.

├── provider.tf------|| In this we've store the credentials of the Account {Access-key and the Secret-key}

├── terraform.tf-----|| In this we've stored the version of terraform used.   [You can combine the provider and terraform file if you want]

└── README.md-----|| This Is the file you are Currently Reading

#### **Features**

- Creates an AWS S3 bucket for Terraform state storage.

- Configures Terraform to use S3 as the backend.

- Written with reusable and modular Terraform structure.


#### **Prerequisites**

Before using this project, ensure you have:

Terraform installed (v1.0+ recommended)

An AWS account

AWS Secret-access key and the Access Key from IAM:

***
***


## How It Works

#### 1. Creation of "terraform.tf" file 
   
We'll Put the latest provider and version of terraform in this file.

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}
```


#### 2. Creation of the "provider.tf" File

In the Provider file we usually put the provider we are going to use, and store our Credentials

- In our case it's AWS

```
provider "aws" {
  access_key = "Add your access key here"
  secret_key = "Add your secret key here"
  region     = "ap-south-1" # Your desired AWS region
}
``` 


#### 3. S3 Bucket Creation {main.tf}

Terraform provisions an S3 bucket that will store the Terraform state file:

- Before Settingup the Backend we'll be creating the S3- bucket to store the State the file and'll also create the Object {path to store the state file inside of S3}.

```
resource "aws_s3_bucket" "s3-backend-30-11" {
  bucket = "s3-backend-30-11" # Name of the S3 bucket
  region = "ap-south-1"

  tags = {
    Name = "s3-backend-30-11"
  }
}

resource "aws_s3_object" "State-File" {
  bucket = aws_s3_bucket.s3-backend-30-11.bucket # Reference to the S3 bucket created above
  key    = "State-File/terraform.tfstate"        # Path to the state file in the S3 bucket


  depends_on = [aws_s3_bucket.s3-backend-30-11]
}
```
Name if the S3 Bucket is "s3-backend-30-11"




#### 4. Backend Configuration {backend.tf}

The backend configuration instructs Terraform to store its state in the S3 bucket:

```
// s3 backend creation 

/*
terraform {
  backend "s3" {
    bucket  = "s3-backend-30-11"             # Name of the S3 bucket
    key     = "State-File/terraform.tfstate" # Path to state file in the S3 bucket
    region  = "ap-south-1"
    encrypt = true
  }
}
*/


// End of s3 backend creation

# To access the Above S3 backend creation code, remove the comment syntax (/*):in line 3 and (*/): in line 12.

```

- The Syntax Should be removed after the creation of S3-Bucket.

- If you Do remove the (/* and */) syntax before creating the S3 bucket it'll show the error and will not complete the task.


```

Note:

Terraform does not allow variable usage in the backend block.
Ensure bucket name, region, and key are hard-coded or configured via CLI/ENV.

```

#### 5. Output file {output.tf}

In this file we'll define the output we want,
Let's suppose we want the bucket name and the state file path in the S3 Bucket.

```
output "S3-bucket-name" {
  value       = aws_s3_bucket.s3-backend-30-11.bucket
  description = "The name of the S3 bucket created"
}

output "S3-object-key" {
  value       = aws_s3_object.State-File.key
  description = "The key of the S3 object created for the state file"
}

```

***
***


## How to Use This Project

After Creating the above file you'll use these command to Build the S3 bucket.

1. Initialize Terraform

    ``terraform init``

2. Format Document 

    ``terraform fmt``

3. Validate the configuration

    ``terraform validate``

4. Preview changes

    ``terraform plan``

5. Apply infrastructure

    ``terraform apply`` then write "yes" when asked to confirm.

- With this you have created your S3-Bucket and not to set Up Backend we be doing this command.

**Firstly before writing command we'll now remove the ``/*`` and ``*/`` syntax from the ``backend.tf`` file**.

- Now that the Syntax is removed and code in Not commented.
- we'll run these commands

6. We'll Initalize the Terraform again

    ``terraform init`` and this time it will ask to confirm and then press ``yes``.

***
***



### Outputs

Any resource information you output (e.g., bucket ARN) will display after terraform apply.


***
***


## Cleanup

To destroy all resources created by Terraform we usually use this command :
```
terraform destroy
```
But in this the you can't directly delete these resources:

Reason:

- We have out state file in the S3 so we can't delete that and because of that the command will fail
  
**There are Two ways to delete the S3 Bucket.**

1. You can go to console and delete it manually.

2. Or you can Do this, Let's see how we can delete through Terraform.

Firstly we'll be migrating/transfering the State file to our local from the S3, Using this Command:

```
terraform init --migrate-state
```

Then it'll ask for Confirmation Type ``yes``

- **When the Migration is done simply comment out the ``backend.tf`` file using the Syntax ``/*`` and ``*/`` as it is done before.**

Now That the Backend.tf file is Commented out, and the State file is migrated to the Local we can destroy it:

```
terraform destroy --auto-approve
```

With this Your entire things'll be destroyed.

```
How to Check If the State file is migrated to S3 or Back to Local from S3:

You can just check the "terraform.tfstate" file and If it's empty then it is in you beckend i.e. S3 and 
if it's filled with state then the State file migrated to your Local.

```




***
***

### Notes

For production setups, it is recommended to enable:

S3 versioning

S3 encryption

Bucket policies

DynamoDB for state locking

Never store sensitive information inside state or committed code.

***
***

## License

This project is open-source and free to use.
***

## Contact

For questions or support regarding this project, feel free to reach out:

**Prashant Rawat**  
[LinkedIn Profile](https://www.linkedin.com/in/prashantrawat13/)
***
***
