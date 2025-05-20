FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN rm -r /etc/apt/sources.list.d/debian.sources && \
    echo "deb http://deb.debian.org/debian bookworm main\n\
    deb http://security.debian.org/debian-security bookworm-security main\n\
    deb http://deb.debian.org/debian bookworm-updates main" > /etc/apt/sources.list && \
    apt-get update && apt-get install -y netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

COPY . .

CMD ["/wait-for-it.sh", "opencart", "8080", "--"]