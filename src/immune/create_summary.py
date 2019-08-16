import numpy as np
import pandas as pd
import os.path
from os import path

start = 3
end = 138

sample = start
sample_name = "PIVUS%03d" % (start)

col_names = pd.read_csv('/users/j29tien/ROP/results/'+sample_name+'_ROP/06_immune/'+sample_name+'_Aligned--06_immune_clonality/summary.cdr3.txt').columns.values

cdr3_df = pd.DataFrame(columns=col_names)
VJ_df = pd.DataFrame(columns=col_names)
counter = 0

while True:
    if path.exists('/users/j29tien/ROP/results/'+sample_name+'_ROP/06_immune/'+sample_name+'_Aligned--06_immune_clonality/summary.cdr3.txt'):
        next_cdr3 = pd.read_csv('/users/j29tien/ROP/results/'+sample_name+'_ROP/06_immune/'+sample_name+'_Aligned--06_immune_clonality/summary.cdr3.txt')
        cdr3_df.loc[counter] = next_cdr3.loc[0]        
    if path.exists('/users/j29tien/ROP/results/'+sample_name+'_ROP/06_immune/'+sample_name+'_Aligned--06_immune_clonality/summary.VJ.txt'):
        next_VJ = pd.read_csv('/users/j29tien/ROP/results/'+sample_name+'_ROP/06_immune/'+sample_name+'_Aligned--06_immune_clonality/summary.VJ.txt')
        VJ_df.loc[counter] = next_VJ.loc[0]    
    if sample == end:
        break
    sample += 1
    sample_name = "PIVUS%03d" % (sample)
    counter += 1

cdr3_df.to_csv("/users/j29tien/ROP/results/IMMUNE/samples_cdr3.csv", index=False)
VJ_df.to_csv("/users/j29tien/ROP/results/IMMUNE/samples_VJ.csv", index=False)

