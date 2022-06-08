variable "region" {
  description = "AWS of region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "vpc name"
  type        = list(any)
  default     = ["10.0.0.0/16"]
}

variable "pub_subnet_cidr" {
  description = "public subnet cidr"
  type        = list(any)
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "priv_subnet_cidr" {
  description = "private subnet cidr"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "database_subnet_cidr" {
  description = "database subnet cidr"
  type        = list(any)
  default     = ["10.0.51.0/24", "10.0.53.0/24"]
}

variable "create_vpc" {
  type        = bool
  description = "Create vpc for kojitechs"
  default     = true
}

variable "environment" {
  description = "Environment this template would be deployed to"
  type        = map(string)
  default     = {}
}