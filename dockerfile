FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Create environment variables
ARG USERNAME=sdwui
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# Install essential dependencies and TCMalloc
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    git \
    python3 \
    python3-venv \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    libtcmalloc-minimal4 \
    && rm -rf /var/lib/apt/lists/*

# Grant sudo permissions without a password for the user
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to the non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Clone the Stable Diffusion WebUI repository
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# Enter the Stable Diffusion directory
WORKDIR /home/$USERNAME/stable-diffusion-webui

# Grant execution permissions to webui-user.sh
RUN chmod +x webui-user.sh

# Configure environment variables
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV PATH="/home/$USERNAME/stable-diffusion-webui/venv/bin:$PATH"

# Force the use of TCMalloc
ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"

# Keep the container open
CMD ["/bin/bash"]
