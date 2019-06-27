#!/bin/bash
kill -9 `ps aux |grep 'nginx'|grep -v grep|awk '{print $2}'`
kill -9 `ps aux |grep mkdocs|grep -v grep|awk '{print $2}'`
cd /mkdocs/book
mkdocs build
systemctl start nginx
systemctl restart nginx
