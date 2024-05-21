Proxy w/o user
====
Receiving HTTP proxy request without user authentication and trasfering it to the proxy server that requires user authentication.

## To build docker image
1. `docker compose build`
    - |Variables|Meaning|
      |--|--|
      |build_time_proxy|proxy settings for building image|

## To run it as the server
1. Assign environment variables
    - |Variables|Meaning|
      |--|--|
      |proxy_user|User name for the proxy to be passed|
      |proxy_pwd|Password for the proxy to be passed|
      |proxy_host_port|Host name and port number for the proxy to be passed|
      |restart|Restart docker container after reboot if its value is "restart"; Keep stopping if it is "no"|
2. `docker compose up -d`
