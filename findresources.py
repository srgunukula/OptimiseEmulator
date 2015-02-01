
import os
import re

def findResources(path):
	print "echo Cleaning " + path

	dirEntries = os.listdir(path)

	for entry in dirEntries:
		match = re.search(r".r[0-9]+$", entry)

		if match:
			ext = match.group(0)

			if ext != ".r01":
				print "del " + path + "\\" + entry + " 2> nul:"

print "@echo off"
findResources(r"\epoc32\release\winscw\udeb\z\private\10003a3f\apps")
findResources(r"\epoc32\release\winscw\udeb\z\private\10003a3f\import\apps")
findResources(r"\epoc32\release\winscw\udeb\z\resource")
findResources(r"\epoc32\release\winscw\udeb\z\resource\plugins")
findResources(r"\epoc32\release\winscw\urel\z\private\10003a3f\apps")
findResources(r"\epoc32\release\winscw\urel\z\private\10003a3f\import\apps")
findResources(r"\epoc32\release\winscw\urel\z\resource")
findResources(r"\epoc32\release\winscw\urel\z\resource\plugins")
