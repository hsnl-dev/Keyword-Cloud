import pandas as pd
import dateutil.parser as dp


def filter_rawdata(path):
    df = pd.read_csv(path, sep=',')
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


def vid_dict(result):
    timeSequence = 14  # every 14 second is a sequence
    vid_list = result.videoId.unique()
    for i in range(len(vid_list)):
        filtered = result[(result['videoId'] == vid_list[i])]
        filtered = filtered.reset_index(drop=True)
        # count sequence num
        totalSeq = round(float(filtered['videoTotalTime'][0])/timeSequence)
        for j in range(len(filtered)):
            videoEndTime = filtered['videoEndTime'][j]
            ratio = round(float(videoEndTime)) / timeSequence
            remain = round(float(videoEndTime)) % timeSequence
            if remain > 0:
                ratio = round(ratio + 1)
            print ratio


path = '../mongoDB/848.csv'
result = filter_rawdata(path)
vid_dict(result)
