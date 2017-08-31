eval $(ssh-agent -s)
ssh-add <(echo "${SSH_PRIVATE_KEY}")
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
scp package/geth-exporter*.deb aptly@${REPOSITORY_SERVER}:/var/lib/aptly/store
ssh aptly@${REPOSITORY_SERVER} /usr/bin/aptly add
ssh aptly@${REPOSITORY_SERVER} /usr/bin/aptly publish
