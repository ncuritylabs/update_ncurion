# update_ncurion

## update_201228.sh

* [개선]: syslog 연동 기능
  * 연동 성능 개선(redis 이용)
  * port, protocol 설정 기능 추가
    * logtransfer syslog set [ -p <port> -t <protocol> ] <ipv4> [ipv4] [ipv4] 
