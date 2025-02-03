from time import sleep
from utils.clear import clear

BORDA = "=========================================================================="
DIVISORIA = ".........................................................................."


def print_header(title, subtitle, centralizar=True):
	clear()
	title_lines = title.splitlines()
	subtitle_lines = subtitle.splitlines()
	print(BORDA)

	if centralizar or centralizar == "TITLE":
		for line in title_lines:
			print(line.center(len(BORDA)))
	else:
		for line in title_lines:
			print(line)
	
	print(BORDA)

	if centralizar or centralizar == "SUBTITLE":
		for line in subtitle_lines:
			print(line.center(len(BORDA)))
	else:
		for line in subtitle_lines:
			print(line)
	print(DIVISORIA)


def print_fala(autor, fala):
  print(f"{autor}: {fala}")
  print(DIVISORIA)
  sleep(2)