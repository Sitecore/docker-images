#!/bin/bash
# temp fix: to-do
find /var/opt/mssql/data -name "*_log.ldf" | while read fname; do mv $fname ${fname/_log.ldf/.ldf} ; done