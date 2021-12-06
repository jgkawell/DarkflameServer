# syntax=docker/dockerfile:1
FROM python:latest
LABEL org.opencontainers.image.title='darkflame/accountmanager'
WORKDIR /usr/local/share/
RUN git clone https://github.com/DarkflameUniverse/AccountManager
WORKDIR AccountManager
RUN pip3 install -r requirements.txt && \
        echo "SECRET_KEY = r'$(openssl rand -base64 30)'" > credentials.py && \
        echo "DB_URL = r'mysql+pymysql://${LUDB_MYSQL_USER}:${LUDB_DATABASE_PASSWORD}@lu-database/${LUDB_USER_DB_NAME}'" >> credentials.py && \
        echo "LOGO = 'static/logo/logo.png'" > resources.py && \
        echo "PRIVACY_POLICY = 'policy/Privacy Policy.pdf'" >> resources.py && \
        echo "TERMS_OF_USE = 'policy/Terms of Use.pdf'" >> resources.py
EXPOSE 5000
HEALTHCHECK --interval=2m --timeout=3s \
        CMD curl -f http://localhost:5000 || exit 1
CMD python3 app.py
