

variable "vpc_cidr" {
  description = "vpc name"
  type        = list(any)
}

variable "create_vpc" {
  type        = bool
  description = "Create vpc for kojitechs"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "enable dns hostnames"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "enable dns support"
  default     = true
}

variable "pub_subnet_cidr" {
  description = "public subnet cidr"
  type        = list(any)
}

variable "pub_subnet_az" {
  description = "Public subnet azs"
  type        = list(any)
  deafult = []
}

variable "priv_subnet_cidr" {
  description = "private subnet cidr"
  type        = list(any)
    deafult = []
}

variable "priv_subnet_az" {
  description = "Private subnet azs"
  type        = list(any)
    deafult = []
}

variable "database_subnet_cidr" {
  description = "database subnet cidr"
  type        = list(any)
    deafult = []
}

variable "database_subnet_az" {
  description = "Database subnet az"
  type        = list(any)
    deafult = []
}
