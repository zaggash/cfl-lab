Presentation : May 23rd 1pm

### Set variables
`cp terraform.tfvars.orig terraform.tfvars`

* Fill terraform.tfvars with your AWS credentials.
  You'll also need Digitalocean Credentials for S3 access.

* Set the aws_region to deploy to.

* Set existing vpc_id and subnet_id from the region.

* Each downstream need a Security Group name and an AMI to be available on the region.
----

* prefix variable is set using the workspace name, only set it if not using workspace.
* Others generally do not have to be changed.

#### To bootstrap the labs:
```
./bootstrap_labs.sh
```

The script will log terraform output for each labs.

#### Destroy the labs:
```
[if 15 labs?]

for lab in {1..15}; do ./workspace.sh "cfl-lab${lab}" destroy &; done
for lab in {1..15}; do terraform workspace delete "cfl-lab${lab}" ; done
```

#### Manage dedicated lab:
```
./workspace.sh [lab_name] [apply | destroy | plan | output]
```
