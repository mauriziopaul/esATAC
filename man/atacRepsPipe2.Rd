% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Methods.R
\name{atacRepsPipe2}
\alias{atacRepsPipe2}
\title{Pipeline for multi-replicates case-control paired-end sequencing data}
\usage{
atacRepsPipe2(genome, caseFastqInput1, caseFastqInput2, ctrlFastqInput1,
  ctrlFastqInput2, caseAdapter1 = NULL, caseAdapter2 = NULL,
  ctrlAdapter1 = NULL, ctrlAdapter2 = NULL, refdir = NULL,
  tmpdir = NULL, threads = 2, interleave = FALSE, createReport = TRUE,
  motifs = NULL, chr = c(1:22, "X", "Y"), p.cutoff = 1e-06, ...)
}
\arguments{
\item{genome}{\code{Character} scalar. The genome(like hg19, mm10, etc.) reference data in "refdir" to be used in the pipeline.}

\item{caseFastqInput1}{\code{List} scalar. Input for case samples.
For single-end sequencing,
it contains sequence file paths.
For paired-end sequencing, it can be file paths with #1 mates paired
with file paths in fastqInput2
And it can also be interleaved file paths when argument
interleaved=\code{TRUE}.
Each element in the caseFastqInput1 \code{List} is for a replicate
It can be a \code{Character} vector of FASTQ files paths to be merged.}

\item{caseFastqInput2}{\code{List} scalar. Input for case samples.
It contains file paths with #2
mates paired with file paths in caseFastqInput1
For single-end sequencing files and interleaved paired-end sequencing
files(argument interleaved=\code{TRUE}),
it must be \code{NULL}.
Each element in the caseFastqInput2 \code{List} is for a replicate}

\item{ctrlFastqInput1}{\code{List} scalar. Input for control samples.
For single-end sequencing,
it contains sequence file paths.
For paired-end sequencing, it can be file paths with #1 mates paired
with file paths in ctrlFastqInput2
And it can also be interleaved file paths when argument
interleaved=\code{TRUE}.
Each element in the ctrlFastqInput1 \code{List} is for a replicate
It can be a \code{Character} vector of FASTQ files paths to be merged.}

\item{ctrlFastqInput2}{\code{List} scalar. Input for control samples.
It contains file paths with #2
mates paired with file paths in fastqInput1.
For single-end sequencing files and interleaved paired-end sequencing
files(argument interleaved=\code{TRUE}),
it must be \code{NULL}.
Each element in the ctrlFastqInput1 \code{List} is for a replicate}

\item{caseAdapter1}{\code{Character} scalar. Adapter for caseFastqInput1.}

\item{caseAdapter2}{\code{Character} scalar. Adapter for caseFastqInput2.}

\item{ctrlAdapter1}{\code{Character} scalar. Adapter for ctrlFastqInput1.}

\item{ctrlAdapter2}{\code{Character} scalar. Adapter for ctrlFastqInput2.}

\item{refdir}{\code{Character} scalar. The path for reference data being installed to and storage.}

\item{tmpdir}{\code{Character} scalar. The temporary file storage path.}

\item{threads}{\code{Integer} scalar. The max threads allowed to be created.}

\item{interleave}{\code{Logical} scalar. Set \code{TRUE} when files are
interleaved paired-end sequencing data.}

\item{createReport}{\code{Logical} scalar. If the HTML report file will be created.}

\item{motifs}{either\code{\link{PFMatrix}}, \code{\link{PFMatrixList}},
\code{\link{PWMatrix}}, \code{\link{PWMatrixList}}, default: vertebrates motif from JASPAR.}

\item{chr}{Which chromatin the program will processing. It must be identical
with the filename of cut site information files or subset of .
Default:c(1:22, "X", "Y").}

\item{p.cutoff}{p-value cutoff for returning motifs, default: 1e-6.}

\item{...}{Additional arguments, currently unused.}
}
\value{
\code{List} scalar. It is a list that save the result of the pipeline.
Slot "caselist" and "ctrlist": Each of them is a list that save the result for case or control data.
Slot "comp_result": compare analysis result for case and control data
}
\description{
The preset pipeline to process multi-replicates case control study sequencing data.
HTML report files, result files(e.g. BED, BAM files) and
conclusion list will generated. See detail for usage.
}
\details{
NOTE:
Build bowtie index in this function may take some time. If you already have bowtie2 index files or you want to download(ftp://ftp.ccb.jhu.edu/pub/data/bowtie2_indexes) instead of building, you can let esATAC skip the steps by renaming them following the format (genome+suffix) and put them in reference installation path (refdir).
Example: hg19 bowtie2 index files

\itemize{
\item hg19.1.bt2
\item hg19.2.bt2
\item hg19.3.bt2
\item hg19.4.bt2
\item hg19.rev.1.bt2
\item hg19.rev.2.bt2
}

For single end reads FASTQ files,
The required parameters are fastqInput1 and adapter1.
For paired end reads non-interleaved FASTQ files (interleave=FALSE,defualt),
The required parameters are fastqInput1 and fastqInput2.
Otherwise, parameter fastqInput2 is not required (interleave=TRUE)

The paths of sequencing data replicates can be a \code{Character} vector.
For example:

fastqInput1=c("file_1.rep1.fastq","file_1.rep2.fastq")

fastqInput2=c("file_2.rep1.fastq","file_2.rep2.fastq")

The result will be return by the function.
An HTML report file will be created for paired end reads.
Intermediate files will be save at tmpdir path (default is ./)
}
\examples{
\dontrun{
## These codes are time consuming so they will not be run and
## checked by bioconductor checker.


# call pipeline
# for a quick example(only CTCF will be processed)
conclusion <-
    atacRepsPipe2(
        # MODIFY: Change these paths to your own case files!
        # e.g. fastqInput1 = "your/own/data/path.fastq"
     caseFastqInput1=list(system.file(package="esATAC", "extdata", "chr20_1.1.fq.gz"),
                          system.file(package="esATAC", "extdata", "chr20_1.1.fq.gz")),
     # MODIFY: Change these paths to your own case files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     caseFastqInput2=list(system.file(package="esATAC", "extdata", "chr20_2.1.fq.gz"),
                          system.file(package="esATAC", "extdata", "chr20_2.1.fq.gz")),
     # MODIFY: Change these paths to your own control files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     ctrlFastqInput1=list(system.file(package="esATAC", "extdata", "chr20_1.2.fq.bz2"),
                          system.file(package="esATAC", "extdata", "chr20_1.2.fq.bz2")),
     # MODIFY: Change these paths to your own control files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     ctrlFastqInput2=list(system.file(package="esATAC", "extdata", "chr20_2.2.fq.bz2"),
                          system.file(package="esATAC", "extdata", "chr20_2.2.fq.bz2")),
     # MODIFY: Set the genome for your data
     genome = "hg19",
     motifs = getMotifInfo(motif.file = system.file("extdata", "CustomizedMotif.txt", package="esATAC")))


# call pipeline
# for overall example(all human motif in JASPAR will be processed)
conclusion <-
    atacRepsPipe2(
        # MODIFY: Change these paths to your own case files!
        # e.g. fastqInput1 = "your/own/data/path.fastq"
     caseFastqInput1=list(system.file(package="esATAC", "extdata", "chr20_1.1.fq.gz"),
                          system.file(package="esATAC", "extdata", "chr20_1.1.fq.gz")),
     # MODIFY: Change these paths to your own case files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     caseFastqInput2=list(system.file(package="esATAC", "extdata", "chr20_2.1.fq.gz"),
                          system.file(package="esATAC", "extdata", "chr20_2.1.fq.gz")),
     # MODIFY: Change these paths to your own control files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     ctrlFastqInput1=list(system.file(package="esATAC", "extdata", "chr20_1.2.fq.bz2"),
                          system.file(package="esATAC", "extdata", "chr20_1.2.fq.bz2")),
     # MODIFY: Change these paths to your own control files!
     # e.g. fastqInput1 = "your/own/data/path.fastq"
     ctrlFastqInput2=list(system.file(package="esATAC", "extdata", "chr20_2.2.fq.bz2"),
                          system.file(package="esATAC", "extdata", "chr20_2.2.fq.bz2")),
     # MODIFY: Set the genome for your data
     genome = "hg19"
     )
}
}
\seealso{
\code{\link{atacPipe}}
}
\author{
Zheng Wei and Wei Zhang
}
