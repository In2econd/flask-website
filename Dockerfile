FROM python:3.8-slim
ADD static /
ADD templates /
ADD app.py /
ADD requirements.txt /
RUN pip install -r requirements.txt
EXPOSE 80
CMD [ "python", "app.py"]