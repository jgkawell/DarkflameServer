# syntax=docker/dockerfile:1
FROM python:latest
LABEL org.opencontainers.image.title='darkflame/accountmanager'

WORKDIR /usr/local/share/
RUN git clone https://github.com/DarkflameUniverse/AccountManager

WORKDIR AccountManager
ADD credentials_example.py credentials.py
ADD resources_example.py resources.py
RUN pip3 install -r requirements.txt && echo "SECRET_KEY = r'$(openssl rand -base64 30)'" >> credentials.py

EXPOSE 5000
HEALTHCHECK --interval=2m --timeout=3s \
        CMD curl -f http://localhost:5000 || exit 1
CMD python3 app.py
