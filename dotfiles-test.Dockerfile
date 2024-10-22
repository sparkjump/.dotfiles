FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y sudo

# Create a non-root user and group
RUN groupadd -r user && useradd -r -g user -m -s /bin/bash user
# Give the non-root user sudo privileges, no password required
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
COPY --chmod=0755 . /home/user/.dotfiles
CMD ["/home/user/.dotfiles/bootstrap.sh"]
