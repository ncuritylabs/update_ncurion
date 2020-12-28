# update_ncurion

## update_201229.sh

* [기능개선]: swf-decompression on/off
  * 센서 기능
  * nucurion shell: config sensor engine settings applayers set swf-decompression <on/off>
    * 위의 설정 후 센서는 자동으로 재시작됨

## update_201228.sh

* [개선]: syslog 연동 기능
  * 연동 성능 개선(redis 이용)
  * port, protocol 설정 기능 추가
    * logtransfer syslog set [ -p <port> -t <protocol> ] <ipv4> [ipv4] [ipv4] 
