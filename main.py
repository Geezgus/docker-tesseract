from glob import glob

import pdf2image
import pytesseract

pdfs = glob('pdfs/*.pdf')

for pdf in pdfs:
  pages = pdf2image.convert_from_path(pdf, fmt='png')

  for i in range(len(pages)):
    image_str = pytesseract.image_to_string(pages[i], lang='por')

    filename_no_extension = pdf.split('/')[-1].rstrip('.pdf')
    with open(f'{filename_no_extension}_{i}.txt', 'w') as outfile:
      outfile.write(image_str)