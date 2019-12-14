FROM quay.io/maksymbilenko/oracle-12c-base:latest

ENV WEB_CONSOLE false
ENV DBCA_TOTAL_MEMORY 2048
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.1.0/xe/bin
ENV USE_UTF8_IF_CHARSET_EMPTY true
ENV ORACLE_HOME /u01/app/oracle/product/12.2.0/SE
ENV ORACLE_SID xe

ADD scripts /scripts
RUN chmod +x /scripts/*
RUN /scripts/install_xe.sh

EXPOSE 1521 8080

CMD /scripts/startup.sh
