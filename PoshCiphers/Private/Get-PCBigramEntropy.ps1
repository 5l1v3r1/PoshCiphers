Function Get-PCBigramEntropy
{
    <# 
        .Synopsis
        Returns the bigram entropy for the supplied text compared to English bigram frequancies.

        .Description
        Returns the bigram entropy for the supplied text compared to English bigram frequancies.

        .Parameter Plaintext
        Text to generate entropy based on.

        .Example
        Get-PCBigramEntropy -Plaintext "Example"
        16.535234171974
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $True, Position=0, ValueFromPipeline=$True)]
        [String] $Plaintext
    )
    Begin
    {
        [Double]$Entropy = 0
        $Bigrams = Get-PCBigramSquare
    }
    Process
    {
        #Remove anything that is not a letter
        $Plaintext = [Regex]::Replace($Plaintext,'[^a-zA-Z]','').ToUpper()
        #Loop though each pair in the text
        ForEach ($Start in 0..($Plaintext.Length - 2))
        {
            #Create the pair to use
            $Pair = $Plaintext[$Start..($Start + 1)]
            #Calculate the entropy
            $Entropy += $Bigrams[($Pair[0] - 65)][($Pair[1] - 65)]
        }   
    }
    End
    {
        Return [Double]$Entropy
    }
}