#!/bin/bash

# Script pentru configurarea SSH și setarea parolei root

# Verifică dacă scriptul este rulat ca root
if [ "$EUID" -ne 0 ]; then
  echo "Te rog ruleaza acest script ca root."
  exit 1
fi

# Actualizează lista de pachete
apt-get update

# Navighează la directorul /etc/ssh
cd /etc/ssh

# Creează un backup al fișierului sshd_config
cp sshd_config sshd_config.bak

# Editează fișierul sshd_config
sed -i 's/#PermitRootLogin/PermitRootLogin yes/' sshd_config
sed -i 's/#PasswordAuthentication/PasswordAuthentication yes/' sshd_config
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' sshd_config

# Salvează modificările

# Setează parola pentru utilizatorul root
echo "Introdu parola pentru utilizatorul root:"
passwd root

# Repornește serviciile ssh și sshd
systemctl restart ssh
systemctl restart sshd

echo "Configurarea SSH a fost finalizată cu succes!"
