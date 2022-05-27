
variable "region" {
  description = "AWS of region"
  type        = string
  default     = "us-east-1"

}

variable "vpc_cidr" {
  description = "vpc name"
  type        = string
  default     = "10.0.0.0/16"
}

# list [""]
# componentize the subnets
# -2 pub
# -2 priv
# -2 data

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

