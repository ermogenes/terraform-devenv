# terraform-devenv

Exemplo de configuração de uma instância com Docker e Docker Compose no EC2 usando Terraform.

## Passos manuais

Criar um usuário com permissão de admin no AWS Console e logar com ele usando a extensão AWS do VsCode. Isso irá adicionar as credenciais ao arquivo `~/.aws/credentials`. As credenciais serão reutilizadas para terraformar.

Criar uma chave assimétrica localmente para ser utilizada no key-pair, para acesso SSH na instância EC2.

Linux:

```sh
ssh-keygen -f ~/.ssh/NOME-DA-CHAVE
```

Windows:

```sh
ssh-keygen -f %USERPROFILE%/.ssh/NOME-DA-CHAVE
```

## Variáveis

- `my_local_cidr_block` referencia o CIDR do seu [IP local](http://ip4.me/), para inclusão no SG.
- `my_local_credential_key` é o path local da chave assimétrica, sem extensão.
- `my_aws_profile_name` é o nome do profile definido ao logar na extensão da AWS no VsCode.

## Saídas

- `public-ip` indica o IP público atribuído.
- `public-dns` indica o DNS público atribuído.
- `http-url` indica o endereço HTTP caso algo seja publicado na porta 80.
- `ssh-command` indica o comando necessário para realizar SSH na instância EC2.

## Terraformando

Conferir:

```bash
terraform plan
```

Aplicar:

```bash
terraform apply --auto-approve
```

Destruir:

```bash
terraform destroy --auto-approve
```
