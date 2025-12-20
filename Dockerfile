
# Rimaniamo su Ubuntu come richiesto
FROM ubuntu:latest

# 1) Pacchetti di base: python, pip, venv, git
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# 2) Crea la venv ed installa dipendenze dentro la venv (no PEP 668 errors)
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir PyYAML

# 3) Espone la venv al PATH (così "python" e "pip" puntano alla venv)
ENV PATH="/opt/venv/bin:${PATH}"

# 4) Copia i tuoi file nelle posizioni attese
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# 5) Permessi eseguibile ed working dir
RUN chmod +x /entrypoint.sh
WORKDIR /github/workspace

# 6) Entry point dell'action (non cambia la tua logica)
ENTRYPOINT ["/entrypoint.sh"]
