#!/usr/bin/env python3

from distutils.core import setup

setup(name='geth-exporter',
      version='{{VERSION}}',
      description='go-Ethereum exporter for Prometheus',
      author='Alexandru Thomae',
      author_email='<alex@thom.ae>',
      scripts=['geth-exporter'],
      url='https://gitlab.ix.ai/altcoins/geth-exporter',
      )
