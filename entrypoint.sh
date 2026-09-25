#!/bin/bash

<<EOF | echo
Starting entrypoint script...

$(git config --global user.name "${GITHUB_ACTOR}")
$(git config --global user.email "${INPUT_EMAIL}")

$(python /app/feed.py)

$(git add . && git commit -m "Update feed" || echo "No changes to commit")
$(git push origin HEAD:main || echo "No changes to push")

Done!
EOF