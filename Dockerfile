# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /myapp4

# Install only required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libopenblas0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies separately (to leverage caching)
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --no-compile -r requirements.txt

# Copy application files
COPY . .

# Set default command
CMD ["python", "app.py"]
