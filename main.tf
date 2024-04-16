



provider "vault" {
  address = "http://0.0.0.0:8200"
  skip_child_token = true
 
  auth_login {
    path = "auth/approle/login"
 
    parameters = {
      role_id = "c4384986-4f1f-fd0a-5a11-560e35a5149b"
      secret_id = "49b48e87-67d3-c8cc-0b40-13a7a098db18"
    }
  }
}



data "vault_kv_secret_v2""secret"  {
  mount = "secret" // change it according to your mount
  name  = "data" // change it according to your secret
}


resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
 
  tags = {
    Secret = data.vault_kv_secret_v2.example.data["newkey"]
  }
}


