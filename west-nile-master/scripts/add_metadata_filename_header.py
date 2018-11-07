import pandas as pd
import os
import sys
import shutil

import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt

mt_dir = sys.argv[1]           # First argument is path to metadata

# Remove spaces from location names
df = pd.read_csv(mt_dir)
df.columns = df.columns.str.replace(" ","_").str.lower()
df["county"] = df["county"].str.replace("_", "").str.replace(" ", "")
df = df.set_index("scripps_id")

cns_dir = sys.argv[2]           # Second argument is path to directory with consensus sequences that need to be renamed. Consensus sequences need to be named as Wxxx.*.fa
for f in os.listdir(cns_dir):
    _ = f.split("_")
    new_f = ""
    if len(_) == 7:
        _d = df.ix[_[0]]
        _[4] = _d["county"]
        _[5] = str(round(_d["longitude"], 3))
        _[6] = str(round(_d["latitude"], 3))
        new_f = "_".join(_) + ".fa"
    else:
        id = f.split(".")[0]
        _d = df.ix[id]
        _ = [id, _d["collection_date"], _d["country"], _d["state"], _d["county"], str(round(_d["longitude"], 3)), str(round(_d["latitude"], 3))]
        new_f = "_".join(_) + ".fa"
    print(new_f)
    if f == new_f:
        new_f = new_f + ".tmp"
    fin = open(cns_dir+f, mode="r")
    fin.readline()
    fout = open(cns_dir+new_f, mode="w")
    if ".tmp" in new_f:
        fout.write(">"+new_f[:-7]+"\n")
    else:
        fout.write(">"+new_f[:-3]+"\n")
    shutil.copyfileobj(fin, fout)
    fout.flush()
    fin.flush()
    fout.close()
    fin.close()
    os.remove(cns_dir+f)
    if ".tmp" in new_f:
        os.rename(cns_dir+new_f, cns_dir+new_f[:-4])
