## Google API Client

### Drive API

create folder
```apex
GoogleDriveAPIClient client = new GoogleDriveAPIClient();
GoogleDriveCreateResponse response = client.createFolder('FolderName', 'ParentID');
```

copy file
```
GoogleDriveCreateResponse response = client.copyFile('SourceID', 'DestFileName', 'ParentID');
```

### SpreadSheet API

updateValues
```apex
SpreadSheetAPIClient client = new SpreadSheetAPIClient();
List<SpreadSheetUpdateValue> values = new List<SpreadSheetUpdateValue>();
values.add(new SpreadSheetUpdateValue('シート1!A1:D5', new List<List<Object>>{
    new List<Object>{
        1,
        2,
        3,
        4
    },
    new List<Object>{
        11,
        22,
        33,
        44
    }
}));
client.updateValues('xxx', values);
```
