FROM python:3.11-slim-bullseye
ENV PYTHONUNBUFFERED 1

#環境変数
ARG WORKDIR

#ディレクトリ作成、ワーキングディレクトリ指定
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

#パッケージインストール(mysqlclientのためにgccが必要)
RUN apt-get update && \
    apt-get -y install gcc libmariadb-dev

#pip/setuptoolsバージョンアップ
RUN pip install --upgrade pip

COPY requirements.txt "$WORKDIR/"
RUN pip install -r requirements.txt
