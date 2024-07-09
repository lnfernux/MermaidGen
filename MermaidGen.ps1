function Parse-MermaidDataInput {
    param(
        [Parameter(Mandatory=$true)]$DataPath,
        [Parameter(Mandatory=$true)][string]$Delimiter
    )
    if(-not (Test-Path $DataPath)){
        Write-Error "DataPath does not exist"
        return
    } else {
        $data = Get-Content $DataPath
        $data = $data -split $Delimiter
        $data = $data | Where-Object { $_ -ne "" }
        return $data
    }
}

function New-MermaidFlowDiagram {
    param(
        [Parameter(Mandatory=$true)][array]$Data,
        [Parameter(Mandatory=$false)][string]$OutputPath
    )
    #We need to know how many nodes to create - our logic is that the $data variable starts and ends with a node
    #Each entry in $data between a node, so entry 2, 4, 6, 8, etc. are the connection details
    $nodeCount = ($Data.Length - 1) / 2
    $nodeCount = [math]::Ceiling($nodeCount)
    $nodeCount = $nodeCount + 1
    
    # Create the markdown for the mermaid diagram
    $flowDiagram = @"
graph LR

"@
    
    # Create the nodes and connections
    for($i = 0; $i -lt $nodeCount; $i++){
        $nodeIndex = $i * 2
        if ($nodeIndex + 2 -lt $Data.Length) {
            $flowDiagram += "$($nodeIndex + 1)((`"$($Data[$nodeIndex])`")) --> |`"$($Data[$nodeIndex + 1])`"| $($nodeIndex + 3)((`"$($Data[$nodeIndex + 2])`"))`n"
        }
    }

    # Add the style to the diagram and end
    for($i = 0; $i -lt $nodeCount; $i++){
        $flowDiagram += "style $($i*2+1) fill:#00f,stroke:#333,stroke-width:4px`n"
    }
    
    # Output the diagram to the specified path if provided
    if ($OutputPath) {
        $flowDiagram | Out-File -FilePath $OutputPath
    } else {
        return $flowDiagram
    }
}