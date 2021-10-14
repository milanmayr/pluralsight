# -----------------------------------------------------------------------------
#  SECRET VARIABLES
# -----------------------------------------------------------------------------

variable "admin_username" {
  type        = string
  description = "Username for the admin account on the VM"
  default     = "milanmayr"
}

variable "admin_ssh_key" {
  type        = string
  description = "File location for public ssh key"
  default     = "~/.ssh/id_rsa.pub"
}

# -----------------------------------------------------------------------------
#  RESOURCE VARIABLES
# -----------------------------------------------------------------------------

variable "subscription_id" {
  type        = string
  default     = "619b068f-9bf3-474c-887a-9dbec6ba6e51"
  description = "Signify Health Sandbox subscription"
}

variable "worker_machines" {
  type = object({
    count = string
  })
  default = {
    count = "3"
  }
}

variable "master_machines" {
  type = object({
    count = string
  })
  default = {
    count = "1"
  }
}