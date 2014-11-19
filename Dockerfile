FROM fedora
MAINTAINER Alain Dejoux <adejoux@krystalia.net>

# update packages
RUN yum update -y

#install lpar2rrd dependencies
RUN yum install -y rrdtool rrdtool-perl httpd
RUN yum install -y perl perl-TimeDate.noarch perl-XML-Simple.noarch perl-XML-SAX.noarch perl-Env perl-CGI

#create lpar2rrd user
RUN useradd -c "LPAR2RRD user" -m lpar2rrd
RUN chmod a+rx /home/lpar2rrd

#add apache and lpar2rrd user limits
ADD limits /limits
RUN cat /limits >> /etc/security/limits.conf

#add httpd configuration for lpar2rrd
ADD lpar2rrd.conf /etc/httpd/conf.d/lpar2rrd.conf

#run httpd
ENTRYPOINT ["/usr/sbin/httpd"] 
CMD ["-D", "FOREGROUND"]
