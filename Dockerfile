FROM python:3.11-slim

WORKDIR /app

COPY flask_app/ /app/

COPY models/vectorizer.pkl /app/models/vectorizer.pkl

RUN pip install -r requirements.txt

ENV NLTK_DATA=/usr/local/nltk_data

RUN python -c "import ssl; ssl._create_default_https_context = ssl._create_unverified_context; import nltk; nltk.download('stopwords'); nltk.download('wordnet')"

EXPOSE 5000

#local
CMD ["python", "app.py"]  

#Prod
#CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]