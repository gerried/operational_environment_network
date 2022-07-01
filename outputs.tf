
output "vpc_id" {
  description = "Kojitechs vpc id"
  value       = try(aws_vpc.kojitechs_vpc[0].id, "")
}

output "vpc_cidr" {
  description = "Kojitechs vpc cidr"
  value       = try(aws_vpc.kojitechs_vpc[0].cidr_block, "")
}

output "public_subnet" {
  description = "Kojitechs public subnet id"
  value       = aws_subnet.pub_subnet.*.id
}

output "public_cidr" {
  description = "Kojitechs public subnet id"
  value       = aws_subnet.pub_subnet.*.cidr_block
}

output "priv_subnet" {
  description = "Kojitechs private subnet id"
  value       = aws_subnet.priv_subnet.*.id
}

output "database_subnet" {
  description = "Kojitechs database subnet id"
  value       = aws_subnet.database_subnet.*.id
}
