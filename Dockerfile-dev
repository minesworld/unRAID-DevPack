FROM unraid-base

COPY packages/6.8 /packages
COPY packages/install.sh /packages/install.sh

RUN chmod +x /packages/install.sh && /packages/install.sh

