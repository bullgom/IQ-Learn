FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libosmesa6-dev \
    patchelf \
    git \
    ffmpeg \
    unzip \
    wget \
    python3-opengl \
    build-essential \
    libglew-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Install Python dependencies
# Copy requirements file first to leverage Docker cache
COPY iq_learn/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy the project files
COPY . /workspace

# Set PYTHONPATH
ENV PYTHONPATH="${PYTHONPATH}:/workspace/iq_learn"

# Default command
CMD ["/bin/bash"]