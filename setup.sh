#! /bin/bash

if [ $# -ne 1 ]; then
    echo "引数が不正"
    exit 1
fi

if [ $1 == "alp-setup" ]; then
    cd && \
    wget https://github.com/tkuchiki/alp/releases/download/v1.0.7/alp_linux_amd64.zip && \
    unzip alp_linux_amd64.zip && \
    sudo mv alp /usr/local/bin
elif [ $1 == "pt-setup" ]; then
    cd && \
    wget https://github.com/percona/percona-toolkit/archive/3.0.5-test.tar.gz && \
    tar zxvf 3.0.5-test.tar.gz && \
    sudo mv /home/isucon/percona-toolkit-3.0.5-test/bin/pt-query-digest /usr/local/bin
elif [ $1 == "pt" ]; then
    cd  && \
    mkdir -p result && \
    touch slow-log.txt
    cd /tmp/ && \
    sudo pt-query-digest slow.log > ~/result/slow-log.txt
elif [ $1 == "go-setup" ]; then
    cd && \
    wget https://dl.google.com/go/go1.16.linux-amd64.tar.gz && \
    tar zxvf go1.16.linux-amd64.tar.gz && \
    sudo mv /home/isucon/go  /usr/local
elif [ $1 == "bench" ]; then
    cd && \
    echo -n > /tmp/slow.log
    cd /home/isucon/isucon10-qualify/bench
    ./bench
    mkdir -p result && \
    touch slow-log.txt
    cd /tmp/ && \
    sudo pt-query-digest slow.log > ~/result/slow-log.txt
elif [ $1 == "mysql-setup" ]; then
    cd && \
    sudo apt -y update
    sudo apt install -y mysql-server mysql-client
    sudo cat /etc/mysql/mysql.cnf >> /home/isucon/isucon10-qualify/team/mysql/mysql.conf
    sudo chmod 644 /home/isucon/isucon10-qualify/team/mysql/mysql.conf
    sudo rm /etc/mysql/mysql.cnf && \
    sudo ln -s /home/isucon/isucon10-qualify/team/mysql/mysql.conf /etc/mysql/mysql.cnf
    touch /tmp/slow.log && \
    sudo chmod 777 /tmp/slow.log
    echo slow_query_log=ON >> /home/isucon/isucon10-qualify/team/mysql/mysql.conf
    echo slow_query_log_file=/tmp/slow.log >> /home/isucon/isucon10-qualify/team/mysql/mysql.conf
    echo long_query_time=0.1 >> /home/isucon/isucon10-qualify/team/mysql/mysql.conf
    sudo systemctl restart mysql
else
  echo "command not found"
fi
