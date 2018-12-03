import csv
table_ls = ['Customer', 'Account', 'Depositor', 'Branch', 'Loan', 'Borrower']

def csv2sql(table):
    pre = "/Users/jesseni/Desktop/databaseEXP/bank/"
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
        csv2sql(table)

if __name__ == '__main__':
    main()
