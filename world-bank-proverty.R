

# Remove those rows that are not countries but regions # !(NOT)
wdi_countries=wdi[!wdi$Country.Code %in% c("ARB",	"CSS",	"CEB",	"EAR",	"EAS",	"EAP",	"TEA",	"EMU",	"ECS",
                                                        "ECA",	"TEC",	"EUU",	"FCS",	"HPC",	"HIC",	"IBD",	"IBT",	"IDB",	
                                                        "IDX",	"IDA",	"LTE",	"LCN",	"LAC",	"TLA",	"LDC",	"LMY",	"LIC",	
                                                        "LMC",	"MEA",	"MNA",	"TMN",	"MIC",	"NAC",	"INX",	"OED",	"OSS",	
                                                        "PSS",	"PST",	"PRE",	"SST",	"SAS",	"TSA",  "SSF",	"SSA",	"TSS",
                                                        "UMC",	"WLD"),]



#  train data is form 1981 to 2012. 

# The test data is from 2013 to 2016

# colnames(wdi3v.1960)=c("code", "country", "life","pop","fr")




