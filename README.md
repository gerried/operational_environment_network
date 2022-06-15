# operational_environment_network
This project create the networking module for kojitechs [url](https://github.com/gerried/operational_environment_network)

<!-- prettier-ignore-start -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

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
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Create vpc for kojitechs | `bool` | `true` | no |
| <a name="input_database_subnet_cidr"></a> [database\_subnet\_cidr](#input\_database\_subnet\_cidr) | database subnet cidr | `list(any)` | <pre>[<br>  "10.0.51.0/24",<br>  "10.0.53.0/24"<br>]</pre> | no |
| <a name="input_priv_subnet_cidr"></a> [priv\_subnet\_cidr](#input\_priv\_subnet\_cidr) | private subnet cidr | `list(any)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_pub_subnet_cidr"></a> [pub\_subnet\_cidr](#input\_pub\_subnet\_cidr) | public subnet cidr | `list(any)` | <pre>[<br>  "10.0.0.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS of region | `string` | `"us-east-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | vpc name | `list(any)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


```hcl

```

Module is maintained by [Geraldine Ngwana](gerrie.ngwana@yahoo.ca)
