#!/bin/bash
set -eu
#!/bin/bash
set -eu

if [ -f '/cloudtemp/cloudreve' ]; then
	rm -f /cloudtemp/cloudreve
fi

mv /root/cloudreve /cloudtemp
chmod -R 777 /cloudtemp/cloudreve

if [ ! -f '/cloudtemp/cloudreve.db' ]; then
	mv /root/cloudreve.db /cloudtemp
fi


if [ ! -f '/cloudtemp/conf.ini' ]; then
	mv /root/conf.ini /cloudtemp
fi


/cloudreve/cloudreve
exec "$@"
