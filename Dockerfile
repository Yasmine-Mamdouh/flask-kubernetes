FROM python:3.12.0b3-alpine3.18
WORKDIR /application
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python3", "app.py"]
