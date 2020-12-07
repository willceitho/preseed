The script `script.sh` takes the original Ubuntu image (`$in_image`), unpacks it, changes the installation selection menu, adds the preseeded defaults (oem.seed) and packages it back into the custom image (`$out_image`).


A new user **worker** is created in *oem.seed*, which, like the root, is assigned passwords, in tasksel is selected 

> OpenSSH server, Basic Ubuntu server


At the end of the installation, the `post.sh` script is triggered, where the new user (*$custom_user=worker*) is added to the **sudo** group without a password (modified */etc/sudoers.d/sudogroups*), after which a public key from the master machine is added to its */home/$custom_user/.ssh/authorized_keys* via the `custom_key` variable.