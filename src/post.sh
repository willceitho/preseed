custom_user=worker
custom_key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAvBNVORAabi9zXL9K09b4bmygJ2/xKv1iHmKauWfR7JEsloKbz6r/5WxJzA80LXiG37S9M1wOkFaRhQ6EjDz3HwV20LI7X09Ytlz5qCE4P9TpX3hVtWULoANrVtiErXImNmV0OBax5VEdXMT8Bo2g2r2GIvhlJcNUkL0o6jbY9nOhpLmfDbguk1OgzQS22G4ZGm/zAmf39FBshDl1YjqnHw7eHe35yworyN+HYmxtFV/eBpjBDxVDp5MPjEgnI8ywEgyRbu7shs3RYDpswkTReIiC9md72/yIZR8FRnG3aE5XRBomlhbvossXQCqBvv69rNW4QpummNaRInE6ppfD4a8sItaOuWeA1uHexPALsGPSJbaWq9lhwy1pbIfx5LHCfgP5/l8PBS3bjW0zBk20nBM/f3iJQcQfN38YJvfWIZzDGjvELFcKR9SgPLLVNXdH1y0ty86ykKwYfE9JCtn5xG5AKxNVcJqmJkmNLb7ZW+kwt8RD0l4xGeVbTHm9duk= leo@manjaro'


# Настраиваем подключение к новому пользователю
# Configure connection to new user
usermod -aG sudo $custom_user
echo $custom_user' ALL=(ALL:ALL) NOPASSWD: ALL'   >> /etc/sudoers.d/sudogroups
mkdir -p /home/$custom_user/.ssh
echo $custom_key > /home/$custom_user/.ssh/authorized_keys
chown -R $custom_user:$custom_user /home/$custom_user/

