function Remove-CosmosDbAttachment
{

    [CmdletBinding(DefaultParameterSetName = 'Context')]
    param
    (
        [Alias("Connection")]
        [Parameter(Mandatory = $true, ParameterSetName = 'Context')]
        [ValidateNotNullOrEmpty()]
        [CosmosDb.Context]
        $Context,

        [Parameter(Mandatory = $true, ParameterSetName = 'Account')]
        [ValidateScript({ Assert-CosmosDbAccountNameValid -Name $_ })]
        [System.String]
        $Account,

        [Parameter()]
        [ValidateScript({ Assert-CosmosDbDatabaseIdValid -Id $_ })]
        [System.String]
        $Database,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]
        $Key,

        [Parameter()]
        [ValidateSet('master', 'resource')]
        [System.String]
        $KeyType = 'master',

        [Parameter(Mandatory = $true)]
        [ValidateScript({ Assert-CosmosDbCollectionIdValid -Id $_ })]
        [System.String]
        $CollectionId,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ Assert-CosmosDbDocumentIdValid -Id $_ })]
        [System.String]
        $DocumentId,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ Assert-CosmosDbAttachmentIdValid -Id $_ })]
        [System.String]
        $Id
    )

    $null = $PSBoundParameters.Remove('CollectionId')
    $null = $PSBoundParameters.Remove('DocumentId')
    $null = $PSBoundParameters.Remove('Id')

    $resourcePath = ('colls/{0}/docs/{1}/attachments/{2}' -f $CollectionId, $DocumentId, $Id)

    $null = Invoke-CosmosDbRequest @PSBoundParameters `
        -Method 'Delete' `
        -ResourceType 'attachments' `
        -ResourcePath $resourcePath
}
