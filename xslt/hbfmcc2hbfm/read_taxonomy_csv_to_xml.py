import pandas as pd
from collections import defaultdict
import re

df = pd.read_csv('HBFM-Taxonomie_final.csv',
                 sep=";", header=1)

# print(df.head())

# print(list(df))


# print(df.dtypes)
# alt + strg + r
del df['Unnamed: 0']
# print(df.info())

df = df.dropna(how='all')

# print('###', df.info(), sep="\n")
#
# print(df.describe())
# print(df.iloc[-1:, 0:3])

# print(df['Werk '].nunique())

test_df = df  # df.iloc[0:5, :]


def read_codes_from_cell(c):

    key_list = c.split(',')
    key_list = map(str.rstrip, key_list)

    returned_keys = []

    for key in key_list:
        if re.search('hbfm\d+$', key) is not None:
            returned_keys.append(re.search('hbfm\d+$', key).group(0))

        elif re.search('\d+$', key) is not None:
            returned_keys.append(re.search('\d+$', key).group(0))
        else:
            print('Konnte keinen key finden:', key)
            #raise Exception

    return ','.join(returned_keys)


#print(read_codes_from_cell('test'))

result_dict = defaultdict(list)
print('###')
for index, row in test_df.iterrows():
    # print(row['c1'], row['c2'])
    for level1_col in range(2, 24, 2):
        # print(test_df.columns[level1_col]) # get column name
        # print('HIER', index, level1_col)
        cell = test_df.iloc[index, level1_col]
        next_cell = test_df.iloc[index, level1_col + 1]
        if not pd.isnull(cell):
            is_leaf = True if pd.isnull(next_cell) else False
            # print(test_df.iloc[index, 1], index, ':', level1_col, is_leaf,
            #       cell, 'neighbor:', test_df.iloc[index, level1_col + 1])
            if is_leaf:
                result_dict[test_df.iloc[index, 1]].append(read_codes_from_cell(cell))
            else:
                result_dict[test_df.iloc[index, 1]].append(read_codes_from_cell(next_cell))

d2 = {k: ' '.join(v) for k, v in result_dict.items()}
d3 = {k: v.replace(',',' ') for k, v in d2.items()}
print(d3)
