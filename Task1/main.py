depth = 0
deepest_path = ["filename", 0]
system = set()  # list of tuples
depths_total = 0
depths_length = 0
current_path = '/'

file = open("commands.txt", "r")
for line in file:
    line = line[:-1]  # strip new line - N.B. needs new line at end of file
    if line[0] == '$':
        # New Command
        if line[2:4] == 'ls':
            pass
        elif line[2:] == 'cd ..':
            depth -= 1
            current_path = '/'.join(current_path.split('/')[:-2]) + '/'
            # print(current_path)
        elif line[2:] == 'cd /':
            depth = 0
            current_path = '/'
            # print(current_path)
        elif line[2:4] == 'cd':
            directory_path = current_path + line.split(' ')[2] + '/'
            if directory_path not in system:
                system.add(directory_path)
            depth += 1
            current_path += line.split(' ')[2] + '/'
            # print(current_path)
        else:
            raise Exception("Unrecognised command", line)
    else:
        info, name = line.split(" ")
        file_path = current_path + name
        if file_path not in system:
            if info != 'dir':
                system.add(file_path)

                # Check if new file discovered is the deepest
                if depth > deepest_path[1]:
                    deepest_path = [file_path, depth]

                depths_total += depth + 1
                depths_length += 1
            else:
                system.add(file_path + '/')

# print("deepest path: ", deepest_path)
# print("average depth: ", depths_total / depths_length)
# print("number of files: ", depths_length)

print(str(depths_length) + ',"' + str(deepest_path[0]) + '",' + str(depths_total / depths_length))
