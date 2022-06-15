# operational_environment_network
This project create the networking module for kojitechs [url](https://github.com/gerried/operational_environment_network)

<!-- prettier-ignore-start -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.default_routetable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.pub_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.database_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.priv_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.pub_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.kojitechs_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Create vpc for kojitechs | `bool` | `true` | no |
| <a name="input_database_subnet_az"></a> [database\_subnet\_az](#input\_database\_subnet\_az) | Database subnet az | `list(any)` | n/a | yes |
| <a name="input_database_subnet_cidr"></a> [database\_subnet\_cidr](#input\_database\_subnet\_cidr) | database subnet cidr | `list(any)` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | enable dns hostnames | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | enable dns support | `bool` | `true` | no |
| <a name="input_priv_subnet_az"></a> [priv\_subnet\_az](#input\_priv\_subnet\_az) | Private subnet azs | `list(any)` | n/a | yes |
| <a name="input_priv_subnet_cidr"></a> [priv\_subnet\_cidr](#input\_priv\_subnet\_cidr) | private subnet cidr | `list(any)` | n/a | yes |
| <a name="input_pub_subnet_az"></a> [pub\_subnet\_az](#input\_pub\_subnet\_az) | Public subnet azs | `list(any)` | n/a | yes |
| <a name="input_pub_subnet_cidr"></a> [pub\_subnet\_cidr](#input\_pub\_subnet\_cidr) | public subnet cidr | `list(any)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | vpc name | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet"></a> [database\_subnet](#output\_database\_subnet) | Kojitechs database subnet id |
| <a name="output_priv_subnet"></a> [priv\_subnet](#output\_priv\_subnet) | Kojitechs private subnet id |
| <a name="output_public_subnet"></a> [public\_subnet](#output\_public\_subnet) | Kojitechs public subnet id |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Kojitechs vpc id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage of module

```hcl
module "networking" {
  source = "git::https://github.com/gerried/operational_environment_network"
  
 vpc_cidr = ["10.0.0.0/16"]
pub_subnet_cidr = ["10.0.0.0/24", "10.0.2.0/24"]
pub_subnet_az = ["us-east-1a", "us-east-1b"]
priv_subnet_cidr = ["10.0.1.0/24", "10.0.3.0/24"]
priv_subnet_az = ["us-east-1a", "us-east-1b"]
database_subnet_cidr = ["10.0.51.0/24", "10.0.53.0/24"]
database_subnet_az = ["us-east-1a", "us-east-1b"]
}

```

Module is maintained by [Geraldine Ngwana](gerrie.ngwana@yahoo.ca)
