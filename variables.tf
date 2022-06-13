variable "my_local_cidr_block" {
  // Ver em http://ip4.me/. Exemplo: "1.2.3.4/32"
  description = "Seu IPv4 público, em formato CIDR (/32)."
  type        = string
}

variable "my_local_credential_key" {
  // Criar chaves pública e privada usando:
  // ssh-keygen -f ~/.ssh/nome-da-chave
  //    ou
  // ssh-keygen -f %USERPROFILE%/.ssh/nome-da-chave
  description = "Nome da sua chave (sem extensão, será adicionado `.pub`) para criação do key pair e acesso via SSH."
  type        = string
}

variable "my_aws_profile_name" {
  // Criar um usuário com permissão de admin no AWS Console e logar com ele na extensão AWS do VsCode
  description = "Nome do profile no seu arquivo local de credenciais compartilhadas (em `~/.aws/credentials`)."
  type        = string
}
