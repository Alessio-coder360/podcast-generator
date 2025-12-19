
#!/bin/bash

echo "====================="

# (opzionale ma consigliato) entriamo nella workspace
cd /github/workspace

# Correggi 'confing' -> 'config' e usa gli INPUT_* dell'action
git config --global user.name "${INPUT_NAME}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Esegui il feed.py copiato nel container (come chiedi tu)
python3 /usr/bin/feed.py

# Commit dei cambi
git add -A && git commit -m "Update Feed" || echo "Nessun cambiamento da committare"

## Push corretto (senza il punto)
git push --set-upstream origin main





