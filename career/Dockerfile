FROM python:3.12-alpine
WORKDIR /app

# Copy requirements and install dependencies along with curl
COPY requirements.txt .
RUN apk add --no-cache curl && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

EXPOSE 80

CMD ["sh", "entrypoint.sh"]
