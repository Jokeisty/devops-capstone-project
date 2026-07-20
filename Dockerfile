FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY service ./service
COPY setup.cfg .
COPY .flaskenv .
COPY Makefile .
COPY tests ./tests

RUN useradd -m theia
RUN chown -R theia:theia /app
USER theia

EXPOSE 8080

CMD ["gunicorn","--bind=0.0.0.0:8080","--log-level=info","service:app"]
