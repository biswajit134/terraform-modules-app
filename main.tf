module dev-infra {
  source = "./infra-app"
  env = "dev"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.micro"
  ami_id = "ami-0e35ddab05955cf57"
  hash_key = "LockID"
}

module prd-infra {
  source = "./infra-app"
  env = "prd"
  bucket_name = "infra-app-bucket"
  instance_count = 2
  instance_type = "t2.medium"
  ami_id = "ami-0e35ddab05955cf57"
  hash_key = "LockID"
}


module stg-infra {
  source = "./infra-app"
  env = "stg"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.small"
  ami_id = "ami-0e35ddab05955cf57"
  hash_key = "LockID"
}