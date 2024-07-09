# MermaidGen

A quick proof of concept for creating mermaid diagrams for markdown as code. Inspired by Fabian Baders blog post on ["Find lateral movement paths using KQL Graph semantics"](https://cloudbrothers.info/en/find-lateral-movement-paths-kql-graph-semantics/).

## Current limitations

- Only supports linear flow diagrams
- Assumes that data is structured in the following way
    - Node1, Relationship, Node2, Relationship, Node3, ...

## Usage

### Example 1 - from CSV

```powershell
$Data = Parse-MermaidDataInput -DataPath .\exampledata1.csv -Delimiter ","
$Diagram = New-MermaidFlowDiagram -Data $Data
```

#### Output

```mermaid
graph LR
1(("Takeshi")) --> |"AdminTo"| 3(("Desktop1337"))
3(("Desktop1337")) --> |"HadSession"| 5(("Takeshi"))
5(("Takeshi")) --> |"AdminTo"| 7(("Desktop1339"))
7(("Desktop1339")) --> |"HadSession"| 9(("backupAdmin01"))
9(("backupAdmin01")) --> |"AdminTo"| 11(("Desktop1331010"))
style 1 fill:#00f,stroke:#333,stroke-width:4px
style 3 fill:#00f,stroke:#333,stroke-width:4px
style 5 fill:#00f,stroke:#333,stroke-width:4px
style 7 fill:#00f,stroke:#333,stroke-width:4px
style 9 fill:#00f,stroke:#333,stroke-width:4px
style 11 fill:#00f,stroke:#333,stroke-width:4px
```

### Example 2 - from custom text input

```powershell
$Data = Parse-MermaidDataInput -DataPath .\exampledata2.txt -Delimiter "-->"
$Diagram = New-MermaidFlowDiagram -Data $Data
```

#### Output

```mermaid
graph LR
1(("Takeshi ")) --> |" AdminTo "| 3((" Desktop1337 "))
3((" Desktop1337 ")) --> |" HadSession "| 5((" Takeshi "))
5((" Takeshi ")) --> |" AdminTo "| 7((" Desktop1339 "))
7((" Desktop1339 ")) --> |" HadSession "| 9((" backupAdmin01 "))
9((" backupAdmin01 ")) --> |" AdminTo "| 11((" Desktop1331010"))
style 1 fill:#00f,stroke:#333,stroke-width:4px
style 3 fill:#00f,stroke:#333,stroke-width:4px
style 5 fill:#00f,stroke:#333,stroke-width:4px
style 7 fill:#00f,stroke:#333,stroke-width:4px
style 9 fill:#00f,stroke:#333,stroke-width:4px
style 11 fill:#00f,stroke:#333,stroke-width:4px
```


