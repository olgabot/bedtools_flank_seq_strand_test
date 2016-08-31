# bedtools_flank_seq_strand_test
Repository to test bedtools flank/fasta/strand confusion


## To reproduce the potential bug

To reproduce a potential bug in getting one-off errors in `bedtools flank` and subsequent `bedtools getfasta` where the downstream negative strand splice sites (2nt away from the exon) should be GT but weren't (see below), follow these instructions.

```
➜  outrigger git:(master) ✗ head exon2_2nt*txt
==> exon2_2nt_downstream_sequences.txt <==
chr10:128493330-128493332(-)    TG
chr2:136772690-136772692(+) GT
chr10:128493330-128493332(-)    TG
chr10:128491716-128491718(-)    TA
chr2:136734661-136734663(+) GT
chr10:128491286-128491288(-)    TA
chr2:136772690-136772692(+) GT
chr2:136734661-136734663(+) GT
chr2:136734661-136734663(+) GT
chr2:136774020-136774022(+) GT
```

### Clone the repo

Clone this repository and move to that directory

```
git clone https://github.com/olgabot/bedtools_flank_seq_strand_test.git
cd bedtools_flank_seq_strand_test
```

### Backup the files created

Make backup copies of the current files (which I created - this is so you can compare)

```
mkdir backup
cp exon2_* backup/
make clean
```

### Create the files

The bed files are `mm10` coordinates, so you'll need to supply the `mm10` chromosome sizes (for `bedtools flank`) and genome sequence (for `bedtools getfasta`). By default, they point to:

```
FASTA=~/genomes/mm10/gencode/m10/GRCm38.primary_assembly.genome.fa
GENOME=~/genomes/mm10/mm10.chrom.sizes
```

(This is the top of the makefile)

You can change this by specifying new values, e.g. a different genome fasta file such as `genome.fa` for the `FASTA` value, and a different genome (I know!! so many genomes!!) chromosome sizes file called `mm10.chrom.sizes` in your local directory, by putting them before the `make all` command:

```
FASTA=genome.fa GENOME=mm10.chrom.sizes make all
```