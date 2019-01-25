FROM niuzhenyong/xelatex

RUN apt-get update && \
    apt-get install --yes python3-pip && \
    apt-get autoclean && apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 install sphinx==1.8.3

WORKDIR /doc
VOLUME ["/doc"]
CMD ["bash"]
