# Use an official Python runtime as a parent image (Alpine-based for minimal vulnerabilities)
FROM python:3.13-alpine

# Set the working directory in the container
WORKDIR /app

# Prevent Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE=1
# Ensure Python output is sent straight to terminal (useful for logs)
ENV PYTHONUNBUFFERED=1

# Install system dependencies if needed (e.g., for certain Python packages)
# RUN apt-get update && apt-get install -y --no-install-recommends some-package && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir --upgrade pip uv

# Copy dependency definition files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv pip install --system -r pyproject.toml

# Copy the rest of the application code
COPY main.py .
# COPY session_string_generator.py . # Optional: if needed within the container, otherwise can be run outside

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser:appuser /app
USER appuser

# Define environment variables needed by the application
# These should be provided at runtime, not hardcoded (especially secrets)
ENV TELEGRAM_API_ID=""
ENV TELEGRAM_API_HASH=""
# Specify one of the following at runtime:
# Default session filename
ENV TELEGRAM_SESSION_NAME="telegram_mcp_session"
# Or provide the session string directly
ENV TELEGRAM_SESSION_STRING=""

# Expose any ports if the application were a web server (not needed for stdio MCP)
# EXPOSE 8000

# Create a volume for session persistence
VOLUME ["/app/sessions"]

# Define the command to run the application
CMD ["python", "main.py"] 