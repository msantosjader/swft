FROM python:3.9-slim

WORKDIR /app

ENV PYTHONPATH=/app:$PYTHONPATH

COPY pyproject.toml uv.lock ./

RUN pip install --no-cache-dir uv && uv venv && uv sync

COPY . .
RUN chmod -R 777 /app

EXPOSE 5000

CMD ["uv", "run", "python", "main.py", "--host", "0.0.0.0", "--port", "5000"]
