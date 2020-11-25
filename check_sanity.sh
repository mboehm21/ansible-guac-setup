#!/bin/bash
#
# prerequisites:
# pip3 install yamllint ansible-lint
#

hash yamllint && hash ansible-lint

RETURN=$?

if [ "$RETURN" != 0 ]
then
  echo "You need yamllint and ansible-lint for the linter to work."
  echo "Install them using 'pip3 install yamllint ansible-lint'."
  exit $RETURN
fi

cd "$(dirname "$0")"

yamllint *.yml && \
ansible-lint *.yml && \
yamllint roles/* && \
ansible-lint roles/*

RETURN=$?

if [ "$RETURN" == 0 ]
then
  echo "Ansible sanity-checks successful."
else
  echo "Ansible sanity-checks failed."
fi

exit $RETURN
