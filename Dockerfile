FROM python:3.7-slim
ADD . /
RUN pip install -r requirements.txt
EXPOSE 80
CMD [ "python", "app.py"]