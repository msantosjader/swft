FROM python:3.9-slim

WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv venv && uv sync

COPY . .

RUN adduser --disabled-password --gecos '' python && chown -R python:python /app
USER python

EXPOSE 5000

CMD ["uv", "run", "python", "main.py", "--host", "0.0.0.0", "--port", "5000"]
