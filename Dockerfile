FROM  redpandaci/ubuntu-dind:1.0.0

LABEL Mantainer Maurice Domínguez <maurice.ronet.dominguez@gmail.com>

RUN git config --global user.name "red-panda-ci"
RUN git config --global user.email redpandaci@gmail.com

WORKDIR /workspace

COPY entrypoint.sh /usr/bin/npm-command-runner.sh

RUN chmod u+x /usr/bin/npm-command-runner.sh

CMD ["/usr/bin/npm-command-runner.sh"]
