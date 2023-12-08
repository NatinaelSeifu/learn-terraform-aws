variable "bucket_tag" {
    type = string
    
  }
variable "bucket_name" {
  type = string
}

variable "path_location" {
  type = string
  description = "static website files path location on my local or where ever"
}

variable "ACCOUNT_ID" {
  type = number
}

variable "assets_path" {
  type = string
}

variable "content_version" {
  type = number
}