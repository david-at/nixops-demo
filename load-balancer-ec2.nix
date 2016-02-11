let

  region = "us-east-1";
  accessKeyId = "at-dev"; # symbolic name looked up in ~/.ec2-keys

  ec2 =
    { resources, ... }:
    { deployment.targetEnv = "ec2";
      deployment.ec2.accessKeyId = accessKeyId;
      deployment.ec2.region = region;
      deployment.ec2.securityGroupsIds = [ "sg-85e506fd" "sg-85e506fd" ];
      deployment.ec2.instanceType = "m1.small";
      deployment.ec2.subnetId = "subnet-73a2c12a";
      deployment.ec2.associatePublicIpAddress = true;
      
      deployment.ec2.keyPair = resources.ec2KeyPairs.my-key-pair;
    };

in
{ proxy    = ec2;
  backend1 = ec2;
  backend2 = ec2;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.my-key-pair =
    { inherit region accessKeyId; };
}
