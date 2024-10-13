
FROM node:22@sha256:69e667a79aa41ec0db50bc452a60e705ca16f35285eaf037ebe627a65a5cdf52

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip python3.11-venv

COPY ./ /srv/app/

RUN cd /srv/app/frontend && npm ci
RUN cd /srv/app/frontend && npm run build

ENV VIRTUAL_ENV=/opt/venv
RUN python3.11 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN cd /srv/app && pip install -r requirements.txt

WORKDIR /srv/app
CMD ["python", "app.py"]
EXPOSE 5000
