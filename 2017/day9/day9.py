class StreamGroup:
    def __init__(self):
        self.score = 0
        self.parent = None
        self.children = []
        self.content = ""
        self.garbage_data = []

    def __str__(self):
        return ("StreamGroup{"
                + "score=" + str(self.score)
                + ", parent=" + str(self.parent)
                + ", children=" + str(self.children)
                + ", content=" + self.content
                + ", garbage_data=" + str(self.garbage_data)
                + "}")

    def __repr__(self):
        return str(self)


def read_file(file_name="day9_input.txt"):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def process_garbage_data(stream_data, index, garbage_count):
    garbage_data = "<"
    index += 1

    while stream_data[index] != ">":
        if stream_data[index] == "!":
            index += 1
            garbage_data += "!" + stream_data[index]
        else:
            garbage_data += stream_data[index]
            garbage_count += 1
        index += 1

    garbage_data += ">"
    index += 1
    return garbage_data, index, garbage_count


def process_stream(stream_data, parent, index, score_count, garbage_count):
    group = StreamGroup()
    group.parent = parent
    if group.parent:
        group.score = group.parent.score + 1
    else:
        group.score = 1

    index += 1

    while stream_data[index] != "}":
        if stream_data[index] == "{":
            child, index, score_count, garbage_count = process_stream(stream_data, group, index, score_count, garbage_count)
            group.children.append(child)
        elif stream_data[index] == "<":
            garbage_data, index, garbage_count = process_garbage_data(stream_data, index, garbage_count)
            group.garbage_data.append(garbage_data)
        else:
            group.content += stream_data[index]
            index += 1

    index += 1

    score_count += group.score

    return group, index, score_count, garbage_count




def part12():
    stream_data = read_file()
    print(stream_data)
    parent_group, index, score_count, garbage_count = process_stream(stream_data, None, 0, 0, 0)
    print(parent_group)
    print(score_count)
    print(garbage_count)


part12()
