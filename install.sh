sourcePath="/usr/local/ssr_hhx" # ssr路径
killall python
if [ ! -d "$sourcePath" ]; then
  mkdir "$sourcePath"
fi
cd $sourcePath

if [ -f '/etc/redhat-release'  ] ; then
  yum install -y python git
else
  source /etc/os-release
  cd "$sourcePath"
  if [ "$ID" = "debian" ] || [ "$ID" = "ubuntu" ] ; then
      apt-get install -y  python git
  elif [ "$ID" = "centos" ]; then
      yum install -y  python git
  else
      echo "shit 系统不存在  到github给我提issue "
      echo "https://github.com/huanghuixin1/shadowsocksr.git"
  fi
fi

git clone https://github.com/huanghuixin1/shadowsocksr.git
python /usr/local/ssr_hhx/shadowsocksr/shadowsocks/server.py -p 8899 -k 52hhx.com -m none -O auth_chain_a -o tls1.2_ticket_auth_compatible &

chmod +x /etc/rc.local
sed -i '1i\python /usr/local/ssr_hhx/shadowsocksr/shadowsocks/server.py -p 8899 -k 52hhx.com -m none -O auth_chain_a -o tls1.2_ticket_auth_compatible &' /etc/rc.local

exit 0
