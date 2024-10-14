variable "rule_name" {
  type        = string
  description = "The name of the storage management policy rule."
}

variable "enabled" {
  type        = bool
  description = "Flag to enable or disable the rule."
  default     = true
}

variable "blob_types" {
  type        = list(string)
  description = "The type of blob the rule applies to (e.g., blockBlob)."
}

variable "prefix_match" {
  type        = list(string)
  description = "Optional prefix match for the blobs to which the rule applies."
}

variable "delete_after_days" {
  type        = number
  description = "Number of days after which the blob is deleted."
}

variable "archive_after_days" {
  type        = number
  description = "Number of days after which the blob is archived."
}

variable "cool_after_days" {
  type        = number
  description = "Number of days after which the blob is moved to the cool tier."
}

variable "delete_after_days_snapshots" {
  type        = number
  description = "Number of days after which snapshots are deleted."
}