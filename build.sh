#!/usr/bin/env bash
VERSION="1.0.0-$(date +%s)+$(git rev-parse --short HEAD)"
sed -i -e "s/{{VERSION}}/${VERSION}/g" setup.py
sed -i -e "s/{{VERSION}}/${VERSION}/g" debian/changelog
sed -i -e "s/{{VERSION}}/${VERSION}/g" debian/rules

mk-build-deps
dpkg --unpack geth-exporter*build-deps*.deb
git clean -xfd

debian/rules make-orig-tar
mkdir -p build
mv *.orig.tar* build/
dpkg-buildpackage -us -uc
