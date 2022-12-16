FROM python:3.7

# copy all files
RUN mkdir helloworld
COPY run.py /helloworld
WORKDIR /helloworld

CMD ["python3", "run.py"]