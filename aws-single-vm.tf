{
  "AWSTemplateFormatVersion" : "2010-09-09",

  "Description" : "This template creates a single server installation of Microsoft SharePoint Foundation 2010. **WARNING** This template creates Amazon EC2 Windows instance and related resources. You will be billed for the AWS resources used if you create a stack from this template. Also, you are solely responsible for complying with the license terms for the software downloaded and installed by this template. By creating a stack from this template, you are agreeing to such terms.",

  "Parameters" : {
    "KeyName" : {
      "Description" : "Name of an existing EC2 KeyPair",
      "Type" : "AWS::EC2::KeyPair::KeyName",
      "ConstraintDescription" : "must be the name of an existing EC2 KeyPair."
    },

    "InstanceType" : {
      "Description" : "Type of EC2 instance to launch",
      "Type" : "String",
      "Default" : "t2.micro",
      "AllowedValues" : [ "t1.micro", "t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "m1.small", "m1.medium", "m1.large", "m1.xlarge", "m2.xlarge", "m2.2xlarge", "m2.4xlarge", "m3.medium", "m3.large", "m3.xlarge", "m3.2xlarge", "m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "m4.10xlarge", "c1.medium", "c1.xlarge", "c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge", "c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge", "g2.2xlarge", "g2.8xlarge", "r3.large", "r3.xlarge", "r3.2xlarge", "r3.4xlarge", "r3.8xlarge", "i2.xlarge", "i2.2xlarge", "i2.4xlarge", "i2.8xlarge", "d2.xlarge", "d2.2xlarge", "d2.4xlarge", "d2.8xlarge", "hi1.4xlarge", "hs1.8xlarge", "cr1.8xlarge", "cc2.8xlarge", "cg1.4xlarge"],
      "ConstraintDescription" : "must be a valid EC2 instance type."
    },

   "Network" : {
     "Description" : "The Network to the EC2 instances",
     "Type": "String"
   },

   "Subnet" : {
     "Description" : "The IP address range that can be used to SSH to the EC2 instances",
     "Type": "String"
   }
},

   "Metadata": {
   "SNC::Parameter::Metadata": {
     "KeyName":{
       "datasource":"ServiceNow::Pools::CloudKeyPairPool.getObjectsByLDC"
     },
     "Network":{
       "datasource":"ServiceNow::Pools::NetworkPool.getObjectsByLDC"
     },
     "Subnet":{
       "datasource":"ServiceNow::Pools:: SubnetPool.getObjectsByNetwork",
       "datasourceFilter":{"Network":"Network"}
     }
   }

},

  "Mappings" : {
    "AWSRegion2AMI" : {
      "us-east-1"        : {"Windows2019Base" : "ami-06a4e829b8bbad61e"},
      "us-west-2"        : {"Windows2019Base" : "ami-04ad37d2932b886c0"},
      "us-west-1"        : {"Windows2019Base" : "ami-0069635df219ce9e5"},
      "eu-west-1"        : {"Windows2019Base" : "ami-00b49e2d0e1fc7fad"},
      "eu-west-2"        : {"Windows2019Base" : "ami-0101530e3e27a39e9"},
      "eu-west-3"        : {"Windows2019Base" : "ami-0109f669f0155fac6"},
      "eu-central-1"     : {"Windows2019Base" : "ami-089ca11903ef1567b"},
      "eu-north-1"       : {"Windows2019Base" : "ami-0a1ec014926fa9fdd"},
      "ap-northeast-1"   : {"Windows2019Base" : "ami-0342e79d2629aa47f"},
      "ap-northeast-2"   : {"Windows2019Base" : "ami-066eac07824e13596"},
      "ap-southeast-1"   : {"Windows2019Base" : "ami-0331481cc4fdd340b"},
      "ap-southeast-2"   : {"Windows2019Base" : "ami-0d692d1b5e7f63b6a"},
      "ap-south-1"       : {"Windows2019Base" : "ami-00b2d3ea9077fcebf"},
      "us-east-2"        : {"Windows2019Base" : "ami-017894519635aafd2"},
      "ca-central-1"     : {"Windows2019Base" : "ami-08b0035504b87a83f"},
      "sa-east-1"        : {"Windows2019Base" : "ami-0f203ed70c367edf5"},
    }
  },

  "Resources" : {
    "EC2Instance": {
      "Type" : "AWS::EC2::Instance",
      "Properties": {
        "SubnetId" : { "Ref" : "Subnet" },
        "InstanceType" : { "Ref" : "InstanceType" },
        "ImageId" : { "Fn::FindInMap" : [ "AWSRegion2AMI", { "Ref" : "AWS::Region" }, "Windows2019Base" ]},
        "KeyName" : { "Ref" : "KeyName" }
    }
  }
 }
}
