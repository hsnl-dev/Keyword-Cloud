import pandas as pd
import dateutil.parser as dp


def filter_rawdata():
    df = pd.read_csv('../mongoDB/848.csv', sep=',')
    users = df.userId.unique()
    new_df = []
    for i in range(len(users)):
        drop = []
        filtered = df[(df['userId'] == users[i])]
        filtered = filtered.reset_index(drop=True)

        for j in range(len(filtered)):
            next_i = j + 1
            if next_i >= len(filtered):
                break
            this_time = dp.parse(filtered['time'][j]).replace(tzinfo=None)
            next_time = dp.parse(filtered['time'][next_i]).replace(tzinfo=None)
            duration = next_time - this_time
            duration_sec = duration.seconds
            if duration_sec < 2:
                drop.append(j)
        new_filtered = filtered.drop(filtered.index[drop])
        new_df.append(new_filtered)
    result = pd.concat(new_df).reset_index(drop=True)
    return result

def
