variable "subnet_ids" {
  default = ["subnet-061f09689b5fec91d", "subnet-0816c9187df968b77"]
}

variable "vpc_id" {
  default = "vpc-0c635dfdb2530aa34"
}

variable "image_id" {
  default = "ami-0fc570c8686025902"
}

variable "hour_to_switch_on" {
  default = "9"
}

variable "hour_to_switch_off" {
  default = "18"
}