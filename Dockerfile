FROM python:3.12-alpine

# install linux packages
RUN apk update && apk upgrade
RUN apk add bash
RUN apk add tesseract-ocr
RUN apk add poppler-utils

# download language data
WORKDIR /usr/share/tessdata
RUN wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata
RUN wget https://github.com/tesseract-ocr/tessdata/raw/main/por.traineddata

# set the working directory
WORKDIR /app

RUN pip install pytesseract
RUN pip install watchdog[watchmedo]
RUN pip install pillow
RUN pip install pdf2image

# copy and install required packages
COPY ./requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# copy everything else
COPY . .

# run the application
CMD python3 main.py