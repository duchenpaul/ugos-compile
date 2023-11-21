#!/bin/bash
# Extra steps before compiling

# https://github.com/openwrt/packages/issues/18876
( [ -f "staging_dir/hostpkg/bin/pip3" ] && staging_dir/hostpkg/bin/pip3 install pip setuptools --upgrade  ) || echo "Skip pip3 upgrade"