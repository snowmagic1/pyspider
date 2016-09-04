FROM python:3.4
MAINTAINER leishi <lei.shi.10151@gmail.com>

# install requirements
RUN pip install -U pip setuptools
RUN pip install --egg http://cdn.mysql.com//Downloads/Connector-Python/mysql-connector-python-2.1.3.zip#md5=710479afc4f7895207c8f96f91eb5385
ADD requirements.txt /opt/pyspider/requirements.txt
RUN pip install -r /opt/pyspider/requirements.txt

# add all repo
ADD ./ /opt/pyspider

# run test
WORKDIR /opt/pyspider
RUN pip install -e .[all]

VOLUME ["/opt/pyspider"]
ENTRYPOINT ["python", "run.py", "-c", "./pyspider/config.json"]
EXPOSE 5000 23333 24444 25555

CMD ["all"]
