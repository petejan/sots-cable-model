
import sys
import os
import pandas as pd

# create the output directory
try:
    os.mkdir('output')
except OSError as error:
    pass

# get the load case data
load_cases = pd.read_excel('load_case_data.xlsx')

# get the file name to generate from
if len(sys.argv) > 1:
    input_fn = sys.argv[1]
else:
    input_fn = 'sofs12-case2.cbl'

# just the file name part
file = input_fn.replace('.cbl', '')

out_fn = 'output/' + os.path.basename(file) + '-'

# Opening our text file in read only 
# mode using the open() function 
with open(input_fn, 'r') as file_in:
  
    # Reading the content of the file 
    # using the read() function and storing 
    # them in a new variable 
    data_in = file_in.read() 

    # for each load case, generate a cable input file, substituting the parts from the load cases file
    for i in range(load_cases.shape[0]):
        data = data_in  # create a copy of the input file

        # for each key in the load case file (except the No and PROB columns)
        # Searching and replacing the text using the replace() function
        for lc in load_cases.keys():
            if lc not in ('No', 'PROB'):
                data = data.replace(lc, str(load_cases[lc][i]))

        fn = out_fn+load_cases['No'][i]

        # Opening our text file in write only
        # mode to write the replaced content 
        out_file = fn+".cbl"
        print(i, 'swh', load_cases['SWH'][i], 'output file name', out_file)

        # write the cable input file for this load case
        with open(out_file, 'w') as file: 
          
            # Writing the replaced data in our 
            # text file 
            file.write(data) 

            file.close()