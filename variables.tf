# Variables.
variable "tenancy_ocid"         { type = string }
variable "user_ocid"            { type = string }
variable "private_key_path"     { type = string }
variable "fingerprint"          { type = string }
variable "region"               { type = string }
variable "compartment_id"       { type = string }
variable "public_ip_name"       { type = string }
variable "public_ip_lifetime"   { type = string }
variable "kubernetes_version"   { type = string }