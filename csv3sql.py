import csv
table_ls = ['Student', 'Course', 'SC']

def csv3sql(table):
    pre = "/Users/jesseni/Desktop/databaseEXP/School/"
    file = csv.reader(open(pre+table+'.csv', "r"))
    for i, line in enumerate(file):
        if i == 0:
            continue
        tmp = "insert into `" + table + "` values ("
        if len(line) == 1:
            line = [line]
        for str in line:
            tmp += '\'' + str + '\','
        tmp = tmp[:-1] + ');'
        print(tmp)

def main():
    for table in table_ls:
        csv3sql(table)

if __name__ == '__main__':
    main()
