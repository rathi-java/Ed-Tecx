FROM python:3.12-alpine

WORKDIR /app

# Install dependencies (Java, Node.js, pip upgrade)
RUN apk add --no-cache openjdk17-jre-headless nodejs npm \
    && pip install --upgrade pip

# Set Java environment variables for Alpine
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --timeout=1000 --index-url https://mirrors.aliyun.com/pypi/simple/

# Copy the application code and entrypoint script
COPY . .
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the port for Gunicorn
EXPOSE 80
CMD ["sh", "entrypoint.sh"]
# Set the entrypoint. No CMD is needed now since entrypoint.sh runs gunicorn.
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "readerclub.wsgi:application"]
