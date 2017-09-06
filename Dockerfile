FROM ubuntu:16.10

RUN apt-get update && apt-get install -y --no-install-recommends \
  software-properties-common python-software-properties \
  python3-wheel \
  python3-reportlab \
  python3-venv \
  ghostscript \
  qpdf \
  poppler-utils \
  unpaper \
  libffi-dev \ 
  tesseract-ocr \
  tesseract-ocr-eng \
  tesseract-ocr-fra \
  tesseract-ocr-spa \
  tesseract-ocr-deu

ENV LANG=C.UTF-8

RUN python3 -m venv --system-site-packages /appenv

# This installs the latest binary wheel instead of the code in the current
# folder. Installing from source will fail, apparently because cffi needs
# build-essentials (gcc) to do a source installation 
# (i.e. "pip install ."). It's unclear to me why this is the case.
RUN . /appenv/bin/activate; \
  pip install --upgrade pip \
  && pip install ocrmypdf

ADD pdf2image .

ADD pdf2json .
