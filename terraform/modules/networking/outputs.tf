output "private_subnet" {
  value = aws_subnet.private
}

output "public_subnet" {
  value = aws_subnet.public
}

output "subnet_ids" {
  value = flatten([aws_subnet.public[*].id, aws_subnet.private[*].id])
}