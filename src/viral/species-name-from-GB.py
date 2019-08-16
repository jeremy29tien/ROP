#This short python script is an example of using various methods to find species name based on GenBank ID (given by ROP output)
##UPDATE: this script uses the Entrez efetch() to print out species name and taxonomy given a valid GenBank ID from the command line. Handles if there is no argument provided.

#By using NCBI Entrez efetch()
import sys
from Bio import Entrez
Entrez.email = "jeremy29tien@gmail.com"  # Always tell NCBI who you are

if len(sys.argv) > 1:
	handle = Entrez.efetch(db="nucleotide", id=sys.argv[1], retmode="xml")
else:
	print("GenBank ID missing! Exiting now.")
	sys.exit()

#handle = Entrez.efetch(db="nucleotide", id="AY394995", retmode="xml")
record = Entrez.read(handle)
handle.close()

print "%s\t%s\t%s\t%s\t%s\t%s\t%s\t" % (record[0]["GBSeq_locus"],record[0]["GBSeq_primary-accession"],record[0]["GBSeq_accession-version"],record[0]["GBSeq_definition"],record[0]["GBSeq_source"],record[0]["GBSeq_organism"],record[0]["GBSeq_taxonomy"])


"""
print("LOCUS: " + record[0]["GBSeq_locus"])
print("ACCESSION: "+ record[0]["GBSeq_primary-accession"])
print("VERSION: "+ record[0]["GBSeq_accession-version"])

print("DEFINITION: " + record[0]["GBSeq_definition"]) #Human herpesvirus 1 strain 10-6-1, partial genome
print("SOURCE: " + record[0]["GBSeq_source"]) #Human alphaherpesvirus 1 (Herpes simplex virus 1)
print("ORGANISM: " + record[0]["GBSeq_organism"])
print("TAXONOMY: " + record[0]["GBSeq_taxonomy"])
print("OTHER SEQ IDs: ")
print( record[0]["GBSeq_other-seqids"])
"""


