FROM python:3.12-slim

# Variables de entorno
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema para OpenCV y cámara
# Nota: libgl1-mesa-glx fue reemplazado por libgl1 en Debian reciente
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgomp1 \
    libgstreamer1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    libv4l-0 \
    libopencv-dev \
    python3-opencv \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements primero (para aprovechar caché de Docker)
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Comando de inicio
CMD ["python"]
