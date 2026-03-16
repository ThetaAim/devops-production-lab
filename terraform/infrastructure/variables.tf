variable "enable_nat" {
  description = "Enable Nat Gateway"
  type        = bool
  default     = false
}


variable "enable_alb" {

  description = "Enable Load balancer"
  type        = bool
  default     = false

}

variable "enable_s3" {

  description = "Enable S3"
  type        = bool
  default     = false

}


