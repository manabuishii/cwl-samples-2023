## toil Debug on vscode

jobstoreの中身をデバッグしたい


### デバッグ用のjobstoreを作る

このディレクトリで。

```
toil-cwl-runner --jobStore jobstore1 fail-workflow.cwl fail-workflow.yaml
```

###　デバッグ

以下のように設定する。
特に大事なのは、以下の部分で、これがないと、ライブラリのデバッグができない

`"justMyCode": false,`



```json
{
    "version": "0.2.0",
    "configurations": [
        
        {
            "name": "Python: toil-cwl-runner",
            "type": "debugpy",
            "request": "launch",
            "program": "${workspaceFolder}/venv/bin/toil",  // 仮想環境のtoil-cwl-runnerのパス（例）
            "args": ["status", "./cwl-samples-2023/fail-scatter-examle/jobstore1"],  // コマンドライン引数をリストで指定
            "console": "integratedTerminal", 
            "justMyCode": false,
            "env": {
                "PYTHONPATH": "${workspaceFolder}"  // 必要に応じて修正
            }
        },
        {
            "name": "Python: toil stats",
            "type": "debugpy",
            "request": "launch",
            "program": "${workspaceFolder}/venv/bin/toil", // 仮想環境のtoil-cwl-runnerのパス（例）
            "args": [
                "status",
                "./cwl-samples-2023/fail-scatter-examle/jobstore1"
            ], // コマンドライン引数をリストで指定
            "console": "integratedTerminal",
            "justMyCode": false,
            "env": {
                "PYTHONPATH": "${workspaceFolder}" // 必要に応じて修正
            }
        }
    ]
}
```

## TIPS

debugのメニューがきえたらー、`Reset Menu`みたいのを選ぶと良い。
