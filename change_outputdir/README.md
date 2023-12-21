## InitialWorkDirRequirement 関連

`InitialWorkDirRequirement`
は、`ステージング用途である`というのと、
これを使うときはほぼセットで
`InlineJavascriptRequirement` が必要になると思われる。

### comformance test 56, 特定のファイルが別のファイルとして見える。

これを実行すると`56.txt`が`newfile_5_6.txt`となって出力される。
入力ファイルと、新しいファイル名は、ともに、yamlで指定されている。

正確には、記事を読むべきであるが、開始時点で `56.txt` を `newfile_5_6.txt` として持ち込んでいるようである。

```
cwltool comformance_test_56.cwl comformance_test_56.yaml
```

### ただファイルを作る。その他に存在するファイルを別ファイル名で、持ち込んだファイルをlsをして存在を確認するだけのサンプル

```
cwltool ls_just_create_file.cwl ls_just_create_file.yaml
```

今回試した `cwltool`,`3.1.20220331125206`だと、リンクになってファイルが存在していた。

```
total 8
-r-------- 1 manabu manabu 16 Dec  7 16:04 created_file.txt
-rw-r--r-- 1 manabu manabu  0 Dec  7 16:04 ls_result.txt
lrwxrwxrwx 1 manabu manabu 62 Dec  7 16:04 newfile_7_8.txt -> /home/xxxxxx/cwl-samples-2023/change_outputdir/56.txt
```

### ただ、ディレクトリをつくって、その他に存在するファイルを別ファイル名で、持ち込んだファイルを存在を確認するだけのサンプル

```
cwltool ls_just_create_directory.cwl  ls_just_create_directory.yaml
```

```
cat ls_result_with_directory.txt
total 8
-rw-r--r-- 1 manabu manabu    0 Dec  7 15:56 ls_result_with_directory.txt
lrwxrwxrwx 1 manabu manabu   62 Dec  7 15:56 newfile_5_6.txt -> /home/xxxxxx/cwl-samples-2023/change_outputdir/56.txt
drwxr-xr-x 2 manabu manabu 4096 Dec  7 15:56 outdir_just_created_directory
```

### 入力がファイルで出力がファイル

入力がファイルで、lsし、その結果をファイルとして回収するサンプル

```
cwltool ls1.cwl  ls1.yaml
```

実行後

```
cat ls1_result_file.txt
```


#### わざとエラーを出すサンプル

`ls1_error.cwl`

このファイルの問題点は２つ


- `inputs`ではなくて`input`となっている。
- `shellQuote`がない
  - このため、`input`を`inputs`にしてもエラーがでる。


```diff
(cwltool-venv3) ➜  change_outputdir git:(main) ✗ diff -u ls1_error.cwl ls1.cwl 
--- ls1_error.cwl       2023-12-07 16:35:09.664250352 +0900
+++ ls1.cwl     2023-12-07 16:43:43.487584135 +0900
@@ -2,6 +2,7 @@
 class: CommandLineTool
 requirements:
   InlineJavascriptRequirement: {}
+  ShellCommandRequirement: {}
 baseCommand: [ls] # ここにコマンドを指定
 
 inputs:
@@ -14,9 +15,11 @@
     inputBinding:
       position: 2
       prefix: ">"
+      shellQuote: false
 
 outputs:
   - id: output_file
     type: File
     outputBinding:
-      glob: $(input.dest_filename)
+      glob: $(inputs.dest_filename)
```

### 入力が文字列で、出力がファイル

https://cwl.discourse.group/t/pass-writeable-output-directory-to-a-tool/19/15

`dest_dir` が出来上がる

```
cwltool ls2.cwl ls2.yaml
```

#### 入力が文字列、出力がファイル

サブディレクトリを作っていく

```
cwltool ls3.cwl ls3.yaml
```

### 入力がファイルで、出力が異なるディレクトリに異なるファイル。