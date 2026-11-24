
#  lightweight Python image
FROM python:3.12-slim

#  Python con
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# dependency file
COPY requirements.txt .

# py dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

#  Create  non-root user
RUN useradd --create-home --shell /usr/sbin/nologin appuser

# Run application as non-root user
USER appuser

# Document application port
EXPOSE 6969

#  application health
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health', timeout=2)" || exit 1

#  Start application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:6969", "app:app"]
