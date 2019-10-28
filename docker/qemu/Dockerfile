FROM buildpack-deps:stretch 

RUN groupadd -g 1000 rust && \
    useradd -u 1000 -g 1000 rustecean

RUN git clone git://git.qemu.org/qemu.git; \
    cd qemu; \
    ./configure --target-list=arm-softmmu --enable-modules \
        --enable-tcg-interpreter --enable-debug-tcg \
        --python=/usr/bin/python2.7; \
    make; \
    make install; \
    cd ..; \
    rm -rf qemu

WORKDIR /home/rustecean

USER rustecean

CMD ["./run.sh"]