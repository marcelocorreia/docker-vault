# marcelocorreia/vault

Docker image with [Hashicorp vault](https://www.vaultproject.io) + [AWS CLI](https://aws.amazon.com/cli/) + Goodies

##### Github [https://github.com/marcelocorreia/docker-vault](https://github.com/marcelocorreia/docker-vault)
 
### Packages
    - ca-certificates 
    - update-ca-certificates
    - curl
    - unzip 
    - bash 
    - python 
    - py-pip 
    - openssh 
    - git 
    - make 
    - tzdata
    - awscli (via PIP)  
    - jq
 
## INFO
- Workdir is set to /opt/workspace
- Github: [https://github.com/marcelocorreia/docker-vault](https://github.com/marcelocorreia/docker-vault)
- [Integration](#) with [Concourse CI](http://concourse.ci/) 

## Usage
```bash
$> docker run --rm -v $(pwd):/opt/workspace \
   		marcelocorreia/vault \
   		vault [--version] [--help] <command> [args]
```

## Setting timezone
```bash
$> docker run --rm -v $(pwd):/opt/workspace \
        -e TZ=Australia/Sydney \
   		marcelocorreia/vault \
   		vault [--version] [--help] <command> [args]
```


## Example
```bash
$> docker run --rm -v $(pwd):/opt/workspace \
   		marcelocorreia/vault \
   		vault read path/key
```


### [Check the Concourse CI Pipeline used to build this image](https://github.com/marcelocorreia/docker-vault/blob/master/pipeline.yml) 

#### Concourse Build Configuration Example

```yaml
platform: linux

image_resource:
  type: docker-image
  source:
    repository: marcelocorreia/vault
    tag: 'latest'

inputs:
- name: vault-repo

run:
  path: vault
  args: 
  - plan
  - -var-file
  - variables.tfvars
```

# docker-vault
