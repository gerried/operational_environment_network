
variable "env" {
  description = "List of all accounts"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  type    = list(any)
  default = []
}

variable "pub_subnet_cidr" {
  type    = list(any)
  default = []
}

variable "priv_subnet_cidr" {
  type    = list(any)
  default = []
}

variable "database_subnet_cidr" {
  type    = list(any)
  default = []

}
