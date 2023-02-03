FROM mcr.microsoft.com/devcontainers/rust:latest

RUN sudo apt update
RUN sudo apt install gdb-multiarch openocd qemu-system-arm -y
RUN sudo apt-get install libudev-dev
RUN cargo install cargo-generate
ENV CARGO_HOME=~/.cargo/