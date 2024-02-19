resource "aws_network_acl" "public_nacl" {

  count = var.public_network_acl && length(var.public_subnet_ids) > 0 ? 1 : 0

  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids
  tags       = merge({ "Name" = "public-web-${var.name}"}, var.tags)
}

resource "aws_network_acl_rule" "public_ingress" {
  count = var.public_network_acl && length(var.public_subnet_ids) > 0 ? length(var.public_inbound_acl_rules) : 0

  network_acl_id  = aws_network_acl.public_nacl[0].id

  egress          = false
  rule_number     = var.public_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.public_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.public_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl_rule" "public_egress" {
  count = var.public_network_acl && length(var.public_subnet_ids) > 0 ? length(var.public_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.public_nacl[0].id

  egress          = true
  rule_number     = var.public_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.public_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.public_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.public_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.public_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.public_outbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl" "private_nacl" {

  count = var.private_network_acl && length(var.private_subnet_ids) > 0 ? 1 : 0

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  tags       = merge({ "Name" = "private-app-${var.name}" }, var.tags)
}

resource "aws_network_acl_rule" "private_ingress" {
  count = var.private_network_acl && length(var.private_subnet_ids) > 0 ? length(var.private_inbound_acl_rules) : 0

  network_acl_id  = aws_network_acl.private_nacl[0].id

  egress          = false
  rule_number     = var.private_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.private_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.private_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl_rule" "private_egress" {
  count = var.private_network_acl && length(var.private_subnet_ids) > 0 ? length(var.private_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.private_nacl[0].id

  egress          = true
  rule_number     = var.private_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.private_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.private_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.private_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.private_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.private_outbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl" "data_nacl" {

  count = var.data_network_acl && length(var.data_subnet_ids) > 0 ? 1 : 0

  vpc_id     = var.vpc_id
  subnet_ids = var.data_subnet_ids
  tags       = merge({ "Name" = "private-data-${var.name}" }, var.tags)
}

resource "aws_network_acl_rule" "data_ingress" {
  count = var.data_network_acl && length(var.data_subnet_ids) > 0 ? length(var.data_inbound_acl_rules) : 0

  network_acl_id  = aws_network_acl.data_nacl[0].id

  egress          = false
  rule_number     = var.data_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.data_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.data_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.data_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.data_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.data_inbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl_rule" "data_egress" {
  count = var.data_network_acl && length(var.data_subnet_ids) > 0 ? length(var.data_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.data_nacl[0].id

  egress          = true
  rule_number     = var.data_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.data_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.data_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.data_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.data_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.data_outbound_acl_rules[count.index], "cidr_block", null)
}