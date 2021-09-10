# create_file_index
Makes searching for file meta-data very easy

## Synopsis
This batch file creates two compressed files:
* a simple list of files and directories with their full pathname: `dir_list.txt.xz`
* a table of including file name with complete path, modification date, size, and type: `dir_stat.txt.xz`

## Usage

How to view file list:
* `xz -dc dir_list.txt.xz | less`

How to search for files:
* `xz -dc dir_stat.txt.xz | rg datafile.csv`
* (or use the built-in findstr command)
* `xz -dc dir_stat.txt.xz | findstr /i "datafile"`

## Required Dependencies:
* [xz.exe](https://tukaani.org/xz/)
* [fstat.exe](https://github.com/jftuga/fstat/)
* [timeit.exe](https://github.com/jftuga/timeit/)

## Optional Dependencies:
* [rg.exe](https://github.com/BurntSushi/ripgrep)
* [less.exe](https://github.com/jftuga/less-Windows)

## Truncated Example Output:

**dir_list.txt**
```
C:\github.com\jftuga\create_file_index\create_file_index.bat
C:\github.com\jftuga\create_file_index\LICENSE
C:\github.com\jftuga\create_file_index\README.md
```

**dir_stat.txt**
```
+---------------------+-------+------+--------------------------------------------------------------+
|      MOD TIME       | SIZE  | TYPE |                             NAME                             |
+---------------------+-------+------+--------------------------------------------------------------+
| 2021-09-10 17:44:27 | 1,821 | F    | C:\github.com\jftuga\create_file_index\create_file_index.bat |
| 2021-09-10 17:48:31 | 1,089 | F    | C:\github.com\jftuga\create_file_index\LICENSE               |
| 2021-09-10 17:51:31 |   828 | F    | C:\github.com\jftuga\create_file_index\README.md             |
|                     | 3,738 |      |   (total size for 3 files)                                   |
|                     | 1,246 |      | (average size for 3 files)                                   |
+---------------------+-------+------+--------------------------------------------------------------+
```
