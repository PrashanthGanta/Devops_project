## To get the ip address of the terraform running system
# Used this approach to retrive the ip address
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}