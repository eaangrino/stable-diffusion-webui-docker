FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime

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
    libgl1 \
    libglib2.0-0 \
    libtcmalloc-minimal4 \
    g++ \
    build-essential \
    nano 
    # apt-get clean && rm -rf /var/lib/apt/lists/*

# Grant sudo permissions
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

# Prevent TensorFlow/PyTorch from registering CUDA multiple times
ENV TF_ENABLE_ONEDNN_OPTS=0
ENV NVIDIA_TF32_OVERRIDE=0
ENV XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/local/cuda
ENV CUDA_MODULE_LOADING=LAZY
ENV NVIDIA_VISIBLE_DEVICES=all
ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"

# Activate venv in each bash session (work after run ./webui.sh or make start)
RUN echo 'source /home/sdwui/stable-diffusion-webui/venv/bin/activate' >> /home/sdwui/.bashrc

# Keep the container open
CMD ["/bin/bash"]