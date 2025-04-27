variable "env" {
    description = "This is the enviourment"
    type = string
  
}

variable "bucket_name" {
    description = "This is for bucket name for my infra"
    type = string
  
}

variable "instance_count" {
  description = "instance what you want"
  type = number
}

variable "instance_type" {
  description = "The instance type you want"
  type = string
}

variable "ami_id" {
  description = "AMI id for instance"
  type = string
}

variable "hash_key" {
  description = "Variable hash key dynamo db infra"
  type = string
}