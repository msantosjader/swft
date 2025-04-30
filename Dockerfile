# Stage 1: Build dependencies
FROM python:3.9-slim AS build

# Set working directory
WORKDIR /app

# Install uv for managing the virtual environment
RUN pip install --no-cache-dir uv

# Copy dependency files and install dependencies
COPY pyproject.toml uv.lock ./
RUN uv venv && uv sync --production

# Stage 2: Production image
FROM python:3.9-slim AS production

# Set working directory
WORKDIR /app

# Copy installed dependencies from build stage
COPY --from=build /app /app

# Copy the rest of the application code
COPY . .

# Create and switch to a non-root user for security
RUN adduser --disabled-password --gecos '' python && chown -R python:python /app
USER python

# Expose Flask default port
EXPOSE 5000

# Run the app using UV
CMD ["uv", "run", "python", "main.py"]
