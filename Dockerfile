# --- Build Stage ---
FROM python:3.11 AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- Runtime Stage ---
FROM python:3.11-slim AS runtime

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app.py .
COPY api/ api/
COPY utils/ utils/
COPY templates/ templates/
COPY static/ static/
COPY database/ database/

RUN mkdir -p uploads

ENV FLASK_ENV=production

EXPOSE 5000

RUN useradd -m appuser && chown -R appuser /app
USER appuser

CMD ["python", "app.py"]
