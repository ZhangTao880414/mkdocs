#!/bin/bash
kill -9 `ps aux |grep 'nginx: master'|grep -v grep|awk '{print $2}'`
kill -9 `ps aux |grep mkdocs|grep -v grep|awk '{print $2}'`

