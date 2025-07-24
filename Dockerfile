FROM python:3.9-slim

WORKDIR /app

ENV PYTHONPATH=/app:$PYTHONPATH

COPY pyproject.toml uv.lock ./

# Instala dependências, incluindo o gunicorn
RUN pip install --no-cache-dir uv && uv venv && uv sync

COPY . .

# A permissão 777 é muito ampla para produção, mas mantendo por enquanto.
RUN chmod -R 777 /app

EXPOSE ${PORT}

# CMD alterado para usar Gunicorn com 7 workers
CMD ["uv", "run", "gunicorn", "--workers", "4", "--bind", "0.0.0.0:${PORT}", "main:app"]
