variable "project_name" {
  type = string
}

variable "repositories" {
  type = map(any)
}

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "image_retention_count" {
  type    = number
  default = 10
}

variable "tags" {
  type    = map(string)
  default = {}
}
