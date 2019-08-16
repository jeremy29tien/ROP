import numpy as np

start = 3
end = 138

sample = start
sample_name = "PIVUS%03d" % (start)
unmapped = np.array([])

while True:
    n_unmapped = 0
    with open('/users/j29tien/ROP/results/'+sample_name+'_ROP/'+sample_name+'_Aligned--general.log','r') as f:
	f.readline()
	line = f.readline().split()
	n_unmapped = int(line[1])
	unmapped = np.append(unmapped, n_unmapped)
    if sample == end:
	break
    sample += 1
    sample_name = "PIVUS%03d" % (sample)

unmapped.shape = (136,1)
np.savetxt("/users/j29tien/ROP/results/total_unmapped.csv", unmapped, delimiter=",")


