#!/bin/bash

# vars
tmp=/tmp/ubuntu

build=iso
rebuild=iso/ubuntu

in_image=ubuntu.iso
out_image=ubuntu-custom.iso


function check_isoExist {
	if [ -f "$1" ]
	then
		echo "Check file - $1 succesfully!"
	else
		echo "File $1 not exist. Breaking..."
		exit 1
	fi
}


# Распаковываем образ в $build
# Unpacking image into $build

check_isoExis $in_image

echo "[TASK 1] unpacking ISO"
rm -rf $build/
mkdir $build/
sudo mkdir $tmp
echo "** Mounting image..."
sudo mount -o loop $in_image $tmp  >/dev/null 2>&1
echo "** Syncing..."
rsync -av $tmp $build/ >/dev/null 2>&1
chmod -R u+w $build/
sudo umount $tmp
sudo rm -r $tmp


# Добавляем файлы для preseed
# Adds files for custom Ubuntu image
echo "[TASK 2] copy files"
cp ./src/txt.cfg ./iso/ubuntu/isolinux/txt.cfg
cp ./src/oem.seed ./iso/ubuntu/preseed/oem.seed
cp ./src/post.sh ./iso/ubuntu/preseed/post.sh


# Запаковываем содержимое $build/ в образ $out_image
# Packing content of $build/ into $out_image image
echo "[TASK 3] Calculating MD5 sums..."
rm $rebuild/md5sum.txt
(cd $rebuild/ && find . -type f -print0 | xargs -0 md5sum | grep -v "boot.cat" | grep -v "md5sum.txt" > md5sum.txt)
echo "[TASK 4] Building iso image..."

# sudo apt-get install mkisofs -y  >/dev/null 2>&1

mkisofs -r -V "Custom Ubuntu install" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o $out_image $rebuild/ \
