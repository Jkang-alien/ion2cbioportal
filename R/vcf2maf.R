perl SFDRv166.pl -assoc input.txt -SFDR -out test

arg1 <- "-assoc input.txt"
arg2 <- "-SFDR"
arg3 <- "-out test"
cmd <- paste("perl", "SFDRv166.pl", arg1, arg2, arg3)
system(cmd)
system("perl SFDRv166.pl arg1 arg2 arg3")

program_vcf2maf <- "/home/molpath/mskcc-vcf2maf-decbf60/vcf2maf.pl"
arg1 <- "--input-vcf ${list_input_dir_files[j]}"
arg2 <- "--output-maf ${dir_output}/${list_sample_names[j]}.maf"
arg3 <- "--tumor-id ${list_sample_names[j]}"
system(paste(program_vcf2maf, arg1, arg2, arg3)) 

list.files()