FROM python:3.9-slim

WORKDIR /app

ENV PYTHONPATH=/app:$PYTHONPATH

COPY pyproject.toml uv.lock ./

RUN pip install --no-cache-dir uv && uv venv && uv sync

COPY . .

RUN chmod -R 777 /app

EXPOSE ${PORT}

# ALTERE A LINHA CMD PARA A FORMA "SHELL" (SEM COLCHETES)
CMD uv run gunicorn --workers 7 --bind 0.0.0.0:${PORT} main:app
