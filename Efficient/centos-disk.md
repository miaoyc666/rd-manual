#### centos disk

#### 创建分区操作步骤(此处以/dev/sdb为例说明)
1. 进入分区设置，`fdisk /dev/sdb`
2. 输入`n`创建一个新的分区
3. 输入`p`创建一个主分区
4. 输入分区起始扇区，默认开始位置，可直接输入回车
5. 输入分区结束扇区，默认结束位置，可直接输入回车
6. 输入`p`确认分区
7. 输入`w`保存退出
8. 编辑`/etc/fstab`永久挂载目录
9. /etc/fstab增加下面一行内容，`/dev/sdb1 /newdisk xfs defaults 0 0`

#### 格式化磁盘
```bash
mkfs -t ext4 /dev/sdb1
```
centos7开始默认文件系统是xfs, centos6是ext4，centos5是ext3。xfs速度比ext4快，但是不如ext4稳定。

#### 永久挂载
1. `vim /etc/fstab`
2. /etc/fstab增加下面一行内容，`/dev/sdb1 /data xfs defaults 0 0`
3. `mount -a`生效
 


#### 减少分区1(/home)容量，扩充分区2(/)容量【命令版本】
1. `df -h` 
2. `umount /home/`
3. `df -h`
4. `e2fsck -f /dev/mapper/xxxx`
5. 

#### 减少分区1容量，扩充分区2容量【详情版本】
```bash


[root@qradardev ~]# df -h              # 查看磁盘分区信息
Filesystem             Size  Used Avail Use% Mounted on
devtmpfs               126G     0  126G   0% /dev
tmpfs                  126G   20K  126G   1% /dev/shm
tmpfs                  126G   27M  126G   1% /run
tmpfs                  126G     0  126G   0% /sys/fs/cgroup
/dev/mapper/rhel-root   50G   44G  6.2G  88% /
/dev/sda1             1014M  202M  813M  20% /boot
/dev/mapper/rhel-home  1.6T   35M  1.6T   1% /home
tmpfs                   26G     0   26G   0% /run/user/0
[root@localhost ~]# umount /home/       # 卸载挂载分区
[root@qradardev ~]# df -h              # 查看磁盘分区信息
Filesystem             Size  Used Avail Use% Mounted on
devtmpfs               126G     0  126G   0% /dev
tmpfs                  126G   20K  126G   1% /dev/shm
tmpfs                  126G   27M  126G   1% /run
tmpfs                  126G     0  126G   0% /sys/fs/cgroup
/dev/mapper/rhel-root   50G   44G  6.2G  88% /
/dev/sda1             1014M  202M  813M  20% /boot
tmpfs                   26G     0   26G   0% /run/user/0


[root@localhost ~]# e2fsck -f /dev/mapper/VolGroup-LogVol00 # 检查分区文件的错误性，-f 即使文件系统没有错误迹象，仍强制地检查正确性
e2fsck 1.41.12 (17-May-2010)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/mapper/VolGroup-LogVol00: 21/12804096 files (9.5% non-contiguous), 887832/51200000 blocks
[root@localhost ~]#  /dev/mapper/VolGroup-LogVol00 50G # 调整分区大小为50G
resize2fs 1.41.12 (17-May-2010)
Resizing the filesystem on /dev/mapper/VolGroup-LogVol00 to 13107200 (4k) blocks.
Begin pass 2 (max = 32770)
Relocating blocks             XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Begin pass 3 (max = 1563)
Scanning inode table          XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Begin pass 4 (max = 9)
Updating inode references     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
The filesystem on /dev/mapper/VolGroup-LogVol00 is now 13107200 blocks long.

[root@localhost ~]# mount /home # 重新挂载分区
[root@localhost ~]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-LogVol01	193G  5.4G  177G   3% /
tmpfs                  16G   68K   16G   1% /dev/shm
/dev/sdb1             477M   71M  381M  16% /boot
/dev/mapper/VolGroup-LogVol00	50G  194M   47G   1% /home
[root@localhost ~]# lvreduce -L 50G /dev/mapper/VolGroup-LogVol00 # 缩小空间到50G。使用lvreduce指令用于减少LVM逻辑卷占用的空间大小。可能会删除逻辑卷上已有的数据，所以在操作前必须进行确认。记得输入 “y” 
  WARNING: Reducing active and open logical volume to 50.00 GiB.
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce VolGroup/LogVol00? [y/n]: y
  Size of logical volume VolGroup/LogVol00 changed from 195.31 GiB (50000 extents) to 50.00 GiB (12800 extents).
  Logical volume LogVol00 successfully resized.
[root@localhost ~]# vgdisplay # 查看剩余空间
  --- Volume group ---
  VG Name               VolGroup
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  5
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                3
  Open LV               3
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               409.38 GiB
  PE Size               4.00 MiB
  Total PE              104802
  Alloc PE / Size       67602 / 264.07 GiB # 已经分配的空间大小
  Free  PE / Size       37200 / 145.31 GiB # 可分配的空间大小
  VG UUID               dmX651-3dqe-YCyO-qUYl-ZBX6-1BZe-b7xkVD
   
[root@localhost ~]# lvextend -L +145.31G /dev/mapper/VolGroup-LogVol01 # 分配可用空间
  Rounding size to boundary between physical extents: 145.31 GiB.
  Size of logical volume VolGroup/LogVol01 changed from 195.31 GiB (50000 extents) to 340.62 GiB (87200 extents).
  Logical volume LogVol01 successfully resized.
[root@localhost ~]# resize2fs -p /dev/mapper/VolGroup-LogVol01 # 分区重设大小
resize2fs 1.41.12 (17-May-2010)
Filesystem at /dev/mapper/VolGroup-LogVol01 is mounted on /; on-line resizing required
old desc_blocks = 13, new_desc_blocks = 22
Performing an on-line resize of /dev/mapper/VolGroup-LogVol01 to 89292800 (4k) blocks.
The filesystem on /dev/mapper/VolGroup-LogVol01 is now 89292800 blocks long.

[root@localhost ~]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-LogVol01	336G  5.4G  313G   2% /
tmpfs                  16G   68K   16G   1% /dev/shm
/dev/sdb1             477M   71M  381M  16% /boot
/dev/mapper/VolGroup-LogVol00	50G  194M   47G   1% /home
```

