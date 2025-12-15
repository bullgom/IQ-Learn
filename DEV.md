# Development Guide

This guide explains how to build and use the Docker container for developing IQ-Learn.

## 1. Build the Docker Image

Run the following command from the root of the repository:

```bash
docker build -t iq-learn-dev .
```

## 2. Run the Development Container

To develop inside the container while persisting changes to your local files, mount the current directory to `/workspace`.

```bash
docker run --gpus all -it --rm \
    -v $(pwd):/workspace \
    -p 6006:6006 \
    --name iq-learn-container \
    iq-learn-dev
```

**Flags explanation:**
- `--gpus all`: Enables GPU support inside the container (requires NVIDIA Container Toolkit).
- `-v $(pwd):/workspace`: Mounts your local source code into the container so changes are reflected immediately.
- `-p 6006:6006`: Exposes the TensorBoard port.
- `--rm`: Automatically removes the container when you exit.

## 3. Workflow

Once inside the container, you can run training scripts as described in the README.

**Example:**
```bash
cd iq_learn
python train_iq.py agent=softq env=cartpole expert.demos=10
```

**TensorBoard:**
To view logs, run TensorBoard inside the container:
```bash
tensorboard --logdir iq_learn/logs --bind_all
```
Then open `http://localhost:6006` in your browser.
