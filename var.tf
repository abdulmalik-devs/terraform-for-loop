# Define a list of instance types
variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "m5.large", "t2.small"]
}
  
  
variable "security_group_rules" {
  type = list(object({
    protocol = string
    port     = number
  }))
  default = [
    { protocol = "tcp", port = 22 },
    { protocol = "tcp", port = 80 },
    { protocol = "udp", port = 123 },
  ]
}

variable "domain_names" {
  type    = list(string)
  default = ["dev.com", "devsec.org", "cloudsec.com"]
}

variable "domain_records" {
  type = map(list(object({
    type     = string
    ip       = string
    ttl      = number
  })))
  # default = {
  #   "dev.com" = [
  #     { type = "A", ip = "192.168.0.100", ttl = 300 }
  #   ],
  #   "devsec.org" = [
  #     { type = "A", ip = "192.168.0.110", ttl = 300 }
  #   ],
  #   "cloudsec.com" = [
  #     { type = "A", ip = "192.168.0.120", ttl = 300 }
  #       ]
  # }  
}   