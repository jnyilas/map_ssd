#!/bin/bash
## Joe Nyilas, crafted this
## Sun Microsystems Professional Services
## Oct-12-2008

## Map ssd instances to logical devices and zpool vdevs

PATH=/usr/bin:/sbin:/usr/sbin
POOLS=$(zpool list -Ho name)
AWKF=/tmp/awk.$$

#ssds
iostat -e | grep -v nfs | sed 1,2d | awk '{print $1}' > /tmp/ssd.$$

#dev/dsks
iostat -en | grep -v : |sed 1,2d | awk '{print $NF}' > /tmp/dsk.$$

chk1=$(wc -l /tmp/ssd.$$ | awk '{print $1}')
chk2=$(wc -l /tmp/dsk.$$ | awk '{print $1}')

if [ "${chk1}" -ne "${chk2}" ]; then
	echo "something went wrong. devices can't be mapped"
	exit 1
	/bin/rm -f /tmp/*.$$
fi

#Vendor
iostat  -E | grep Vend | nawk '{print $2}' > /tmp/vend.$$

#Size
iostat  -E | grep Size | nawk '{print $2}' > /tmp/size.$$

paste /tmp/vend.$$ /tmp/size.$$ /tmp/ssd.$$ /tmp/dsk.$$ > /tmp/map.$$

# Header
printf "%-8s%12s%8s%40s%20s\n" Vendor Size Inst "Logical Dev" ZPool
echo '{' >> ${AWKF}
for i in ${POOLS}; do
	POOL_DEV=$(zpool status "${i}" | awk '{print $1}' | egrep "c[0-9][0-9]*t[0-9][0-9]*" | sed 's/s[0-9]//')
	for j in ${POOL_DEV}; do
		#create the report using awk gsub
		echo "  gsub(/${j}/,\"${j} ${i}\");" >> ${AWKF}
        done
done

#print $0
echo '  printf("%-8s%12s%8s%40s%20s\\n",$1, $2, $3, $4, $5);
}' >> ${AWKF}
nawk -f ${AWKF} /tmp/map.$$ > /tmp/rep.$$


if [ $# -eq 1 ]; then
	#filter by argv1
	grep "$1" /tmp/rep.$$
else
	cat /tmp/rep.$$
fi

/bin/rm -f /tmp/*.$$
exit 0
