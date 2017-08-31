#!/usr/bin/env bash

VERSION="${CI_BUILD_REF_NAME}"

PKGNAME=`cat debian/control | grep '^Package: ' | sed 's/^Package: //'`
TAGS=($(git tag -l v*|sort -rV))

>debian/changelog
for ((i=0; i < ${#TAGS[@]}; i++)); do
    tag=${TAGS[i]}
    if [ "${next_tag} " == " " ]; then
      VERSION=${tag#v}
    fi
    next_tag=${TAGS[i+1]}
    echo -e "$PKGNAME (${tag#v}) xenial; urgency=medium\n" >> debian/changelog
    if [ "${next_tag} " == " " ]; then
        git log --pretty=format:'  * %s' $tag >> debian/changelog
        git log --pretty='format:%n%n -- %aN <%aE>  %aD%n%n' $tag >> debian/changelog
    else
        git log --pretty=format:'  * %s' $next_tag..$tag >> debian/changelog
        git log --pretty='format:%n%n -- %aN <%aE>  %aD%n%n' $tag^..$tag >> debian/changelog
    fi
    PREVTAG=$tag
done

sed -i -e "s/{{VERSION}}/${VERSION}/g" setup.py
sed -i -e "s/{{VERSION}}/${VERSION}/g" debian/rules

mk-build-deps
dpkg --unpack geth-exporter*build-deps*.deb
git clean -xfd

debian/rules make-orig-tar
dpkg-buildpackage -us -uc

rm -rf package/
mkdir -p package/
mv *.orig.tar* package/
mv ../geth-exporter_* package/
