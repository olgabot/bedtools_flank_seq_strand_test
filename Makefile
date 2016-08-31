
FASTA=~/genomes/mm10/gencode/m10/GRCm38.primary_assembly.genome.fa
GENOME=~/genomes/mm10/mm10.chrom.sizes

clean:
	rm exon2_*

all: sorted upstream2nt downstream2nt seqs_unstranded seqs_stranded

sorted:
	bedtools sort -i exon2.bed > exon2_sorted.bed

beds := exon2.bed exon2_sorted.bed

upstream2nt: exon2_sorted.bed
	bedtools flank -s -l 2 -r 0 -i exon2_sorted.bed -g $(GENOME) > exon2_sorted_upstream2nt.bed
	bedtools flank -s -l 2 -r 0 -i exon2.bed -g $(GENOME) > exon2_upstream2nt.bed

downstream2nt: exon2_sorted.bed
	bedtools flank -s -l 2 -r 0 -i exon2_sorted.bed -g $(GENOME) > exon2_sorted_downstream2nt.bed
	bedtools flank -s -l 2 -r 0 -i exon2.bed -g $(GENOME) > exon2_downstream2nt.bed

seqs_unstranded: upstream2nt downstream2nt
	bedtools getfasta -tab -fi $(FASTA) \
		-bed exon2_upstream2nt.bed -fo exon2_upstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -fi $(FASTA) \
		-bed exon2_downstream2nt.bed -fo exon2_downstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -fi $(FASTA) \
		-bed exon2_sorted_upstream2nt.bed -fo exon2_sorted_upstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -fi $(FASTA) \
		-bed exon2_sorted_downstream2nt.bed -fo exon2_sorted_downstream2nt_seqs_stranded.txt

seqs_stranded: upstream2nt downstream2nt
	bedtools getfasta -tab -s -fi $(FASTA) \
		-bed exon2_upstream2nt.bed -fo exon2_upstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -s -fi $(FASTA) \
		-bed exon2_downstream2nt.bed -fo exon2_downstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -s -fi $(FASTA) \
		-bed exon2_sorted_upstream2nt.bed -fo exon2_sorted_upstream2nt_seqs_stranded.txt
	bedtools getfasta -tab -s -fi $(FASTA) \
		-bed exon2_sorted_downstream2nt.bed -fo exon2_sorted_downstream2nt_seqs_stranded.txt
